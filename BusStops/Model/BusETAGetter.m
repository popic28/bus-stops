//
//  BusETARequest.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "BusETAGetter.h"

#import "Constants.h"
#import "MLineEstimate.h"

#import "NSURLSession+Promise.h"
#import <PromiseKit/PromiseKit.h>
#import <Mantle/Mantle.h>

NSString *const kLineEstimateJSONArrayKey = @"estimates";

@implementation BusETAGetter

+ (AnyPromise *)estimateArrivalsForBusStopWithID:(NSString *)busID
{
    NSString *urlStrWithBusID = [NSString stringWithFormat:@"%@/%@",[Constants kBUS_API_URL],busID];
    
    return [NSURLSession dataPromiseWithURLString:urlStrWithBusID]
    .then(^id(NSData *data){
        
        NSError *parseError = nil;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        if (parseError) {
            return parseError;
        }
        
        NSArray *estimatesJSONArray = [jsonData objectForKey:kLineEstimateJSONArrayKey];
        if (estimatesJSONArray == nil)
        {
            parseError = [NSError errorWithDomain:[Constants kErrorDomain] code:BusETAGetterErrorCodeEmptyEstimates userInfo:nil];
            return parseError;
        }
        
        return [self lineEstimatesFromLineEstimatesJsonArray:estimatesJSONArray];
    });
}

+ (AnyPromise *)lineEstimatesFromLineEstimatesJsonArray:(NSArray <NSDictionary *>*)jsonArray
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver  _Nonnull resolve) {
        
        NSError *parseError = nil;
        NSArray *parsedList = [MTLJSONAdapter modelsOfClass:[MLineEstimate class] fromJSONArray:jsonArray error:&parseError];
        
        if (parseError)
        {
            resolve(parseError);
        }
        else
        {
            resolve(parsedList);
        }
    }];
}


@end
