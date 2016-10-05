//
//  MBusStop.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "MBusStop.h"

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

@end
