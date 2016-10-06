//
//  CoreDataManager+Testable.m
//  BusStops
//
//  Created by Florian Popa on 10/6/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "CoreDataManager+Testable.h"
#import <CoreData/CoreData.h>

@implementation CoreDataManager (Testable)

- (NSString *)storeType
{
    return NSInMemoryStoreType;
}

@end
