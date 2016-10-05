//
//  MBusStop.h
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Mantle/Mantle.h>

@interface MBusStop : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *busID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSNumber *lon;
@property (nonatomic, strong) NSArray <NSString *> *lines;

@end
