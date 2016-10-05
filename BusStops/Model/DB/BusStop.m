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

@implementation BusStop

// Insert code here to add functionality to your managed object subclass
+ (instancetype)insertOrUpdateWithMBusStop:(MBusStop *)busStop
{
    //TODO: separate db layer out of app delegate and update here too
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    BusStop *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"BusStop"
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
