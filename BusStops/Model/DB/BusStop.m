//
//  BusStop.m
//  
//
//  Created by Florian Popa on 10/5/16.
//
//

#import "BusStop.h"
#import "AppDelegate.h"
#import "MBusStop.h"
#import "BusStop.h"

@implementation BusStop

+ (instancetype)insertOrUpdateWithMBusStop:(MBusStop *)busStop
{
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    BusStop *newEntry = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([BusStop class])
                                                      inManagedObjectContext:context];
    newEntry.busID = busStop.busID;
    newEntry.title = busStop.title;
    newEntry.subtitle = busStop.subtitle;
    newEntry.lat = busStop.lat;
    newEntry.lon = busStop.lon;
    newEntry.lines = busStop.lines;
    
    return newEntry;
}


@end
