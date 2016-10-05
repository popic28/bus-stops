//
//  ThumbnailManager.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "ThumbnailManager.h"

#import "MBusStop.h"
#import "ThumbnailGetter.h"
#import <UIKit/UIKit.h>
#import <PromiseKit/PromiseKit.h>

@implementation ThumbnailManager

+ (AnyPromise *)busStopImageWithBusStop:(MBusStop *)busStop shouldCacheOnDisk:(BOOL)shouldCache
{
    //TODO: check on disk for image with busID name
    UIImage *busStopThumb = nil;
    if (busStopThumb != nil)
    {
        return [AnyPromise promiseWithValue:busStopThumb];
    }
    
    if (NO == shouldCache)
    {
        return [ThumbnailGetter mapThumbnailWithLat:busStop.lat lon:busStop.lon];
    }
    
    return [ThumbnailGetter mapThumbnailWithLat:busStop.lat lon:busStop.lon].then(^(UIImage *image){
        
        //TODO: cache the image using the busID as name
        return [AnyPromise promiseWithValue:image];
    });
}

@end
