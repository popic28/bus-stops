//
//  BusStopsViewItem.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "BusStopsViewItem.h"
#import "MBusStop.h"

@implementation BusStopsViewItem

+(instancetype)loadFromBusStop:(MBusStop *)busStop
{
    BusStopsViewItem *newItem = [[BusStopsViewItem alloc] init];
    newItem.number = busStop.busID;
    newItem.title = busStop.title;
    newItem.subtitle = busStop.subtitle;
    
    return newItem;
}

@end
