//
//  ThumbnailManager.h
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AnyPromise;
@class MBusStop;

@interface ThumbnailManager : NSObject

+ (AnyPromise *)busStopImageWithBusStop:(MBusStop *)busStop shouldCacheOnDisk:(BOOL)shouldCache;


@end
