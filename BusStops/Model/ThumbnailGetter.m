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


@implementation ThumbnailGetter

+ (AnyPromise *)mapThumbnailWithLat:(NSNumber *)lat lon:(NSNumber *)lon
{
    NSError *error = nil;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[Constants kMaps_DefaultParams]];
    
    [params setObject:lat forKey:@"lat"];
    [params setObject:lon forKey:@"lon"];
    [params setObject:[Constants kMaps_API_KEY] forKey:@"key"];
    
    NSURLRequest *request = [OMGHTTPURLRQ GET:[Constants kBUS_API_URL]
                                             :params
                                        error:&error];
    
    return [NSURLSession downloadPromiseWithRequest:request];
}

@end
