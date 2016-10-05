//
//  MBusStop.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "MBusStop.h"
#import "BusStop.h"

@implementation MBusStop

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"busID"      : @"id",
              @"title"      : @"title",
              @"subtitle"   : @"subtitle",
              @"lat"        : @"lat",
              @"lon"        : @"lon",
              @"lines"      : @"lines" };
}

+ (instancetype)busStopWithDBBusStop:(BusStop *)busStop
{
    MBusStop *newBusStop = [[MBusStop alloc] init];
    newBusStop.busID = busStop.busID;
    newBusStop.title = busStop.title;
    newBusStop.subtitle = busStop.subtitle;
    newBusStop.lat = busStop.lat;
    newBusStop.lon = busStop.lon;
    newBusStop.lines = busStop.lines;
    
    return newBusStop;
}

@end
