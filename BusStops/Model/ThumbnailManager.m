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

#import "AppDelegate.h"

@implementation ThumbnailManager

+ (AppDelegate *)appDelegate
{
    return [[UIApplication sharedApplication] delegate];
}

+ (AnyPromise *)busStopImageWithBusStop:(MBusStop *)busStop shouldCacheOnDisk:(BOOL)shouldCache
{
    //check if image exists , saved with busID on disk
    NSString *thumbnailPath = [[[[self appDelegate] applicationDocumentsDirectory] path] stringByAppendingPathComponent:busStop.busID];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:thumbnailPath])
    {
        UIImage *busStopThumb = [UIImage imageWithContentsOfFile:thumbnailPath];
        
        return [AnyPromise promiseWithValue:busStopThumb];
    }
    
    if (NO == shouldCache)
    {
        return [ThumbnailGetter mapThumbnailWithLat:busStop.lat lon:busStop.lon];
    }
    
    return [ThumbnailGetter mapThumbnailWithLat:busStop.lat lon:busStop.lon].then(^(UIImage *image){
        
        NSData *pngData = UIImagePNGRepresentation(image);
        [pngData writeToFile:thumbnailPath atomically:YES];
        
        return [AnyPromise promiseWithValue:image];
    }).catch(^(NSError *error){
        
        NSLog(@"error:%@",error);
    });
}

@end
