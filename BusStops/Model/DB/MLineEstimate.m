//
//  MLineEstimate.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "MLineEstimate.h"

@implementation MLineEstimate

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"name"       : @"line",
              @"direction"  : @"direction",
              @"estimate"   : @"estimate" };
}

@end
