//
//  BusStop.m
//  
//
//  Created by Florian Popa on 10/5/16.
//
//

#import "BusStop.h"
#import "CoreDataManager.h"
#import "MBusStop.h"
#import "BusStop.h"

@implementation BusStop

+ (instancetype)insertOrUpdateWithMBusStop:(MBusStop *)busStop
{
    BusStop *newEntry = (BusStop *)[[CoreDataManager sharedInstance] createNewObjectForEntity:[BusStop class]];
    newEntry.busID = busStop.busID;
    newEntry.title = busStop.title;
    newEntry.subtitle = busStop.subtitle;
    newEntry.lat = busStop.lat;
    newEntry.lon = busStop.lon;
    newEntry.lines = busStop.lines;
    
    return newEntry;
}


@end
