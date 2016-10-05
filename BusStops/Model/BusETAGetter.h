//
//  BusETARequest.h
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AnyPromise;

@interface BusETAGetter : NSObject

+ (AnyPromise *)estimateArrivalsForBusStopWithID:(NSString *)busID;

@end
