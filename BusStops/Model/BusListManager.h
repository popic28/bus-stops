//
//  BusListManager.h
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AnyPromise;

extern NSString *const nBusListManagerDidReloadNotification;


@interface BusListManager : NSObject

+ (instancetype)sharedInstance;

- (AnyPromise *)fetchBusListOfZaragoza;
- (AnyPromise *)arrivalsForBusStopWithID:(NSString *)busID;

@end
