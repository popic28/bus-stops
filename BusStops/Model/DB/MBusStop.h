//
//  MBusStop.h
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Mantle/Mantle.h>

@class BusStop;
NS_ASSUME_NONNULL_BEGIN

@interface MBusStop : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *busID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSNumber *lon;

+ (instancetype)busStopWithDBBusStop:(BusStop *)busStop;

@end

NS_ASSUME_NONNULL_END