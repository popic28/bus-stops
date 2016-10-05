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

NSString *const kmapParamLat = @"lat";
NSString *const kmapParamLon = @"lon";
NSString *const kmapParamAPIKEY = @"key";

@implementation ThumbnailGetter

+ (AnyPromise *)mapThumbnailWithLat:(NSNumber *)lat lon:(NSNumber *)lon
{
    NSError *error = nil;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[Constants kMaps_DefaultParams]];
    
    [params setObject:lat forKey:kmapParamLat];
    [params setObject:lon forKey:kmapParamLon];
    [params setObject:[Constants kMaps_API_KEY] forKey:kmapParamAPIKEY];
    
    NSURLRequest *request = [OMGHTTPURLRQ GET:[Constants kBUS_API_URL]
                                             :params
                                        error:&error];
    
    return [NSURLSession downloadPromiseWithRequest:request];
}

@end
