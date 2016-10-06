//
//  BusListGetter.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "BusListGetter.h"

#import <PromiseKit/PromiseKit.h>
#import "Constants.h"
#import "NSURLSession+Promise.h"

NSString *const kBusStopsArrayJSONKey = @"locations";

@implementation BusListGetter

+ (AnyPromise *)busStopsArray
{
    return [NSURLSession dataPromiseWithURLString:[Constants kBUS_API_URL]].then(^id(NSData *data) {
        
        NSError *parseError = nil;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        if (parseError) {
            return parseError;
        }
        
        NSArray *busStopsJSONArray = [self busListArrayFromBusListDict:jsonData];
        
        return [AnyPromise promiseWithValue:busStopsJSONArray];
    });
}

+ (NSArray *)busListArrayFromBusListDict:(NSDictionary *)busListDict
{
    return [busListDict objectForKey:kBusStopsArrayJSONKey];
}

@end
