//
//  ThumbnailFactory.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "ThumbnailGetter.h"

#import "Constants.h"
#import <OMGHTTPURLRQ/OMGHTTPURLRQ.h>
#import "NSURLSession+Promise.h"
#import <PromiseKit/PromiseKit.h>

NSString *const kmapParamLatAndLon = @"center";
NSString *const kmapParamAPIKEY = @"key";

@implementation ThumbnailGetter

+ (AnyPromise *)mapThumbnailWithLat:(NSNumber *)lat lon:(NSNumber *)lon
{
    NSError *error = nil;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[Constants kMaps_DefaultParams]];
    
    [params setObject:[NSString stringWithFormat:@"%@,%@",lat,lon] forKey:kmapParamLatAndLon];
    [params setObject:[Constants kMaps_API_KEY] forKey:kmapParamAPIKEY];
    
    NSURLRequest *request = [OMGHTTPURLRQ GET:[Constants kMaps_API_URL]
                                             :params
                                        error:&error];
    
    if (error)
    {
        return [AnyPromise promiseWithValue:error];
    }
    
    return [NSURLSession downloadPromiseWithRequest:request];
}

@end
