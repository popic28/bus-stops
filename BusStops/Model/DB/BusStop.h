//
//  BusStop.h
//  
//
//  Created by Florian Popa on 10/5/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@class MBusStop;
NS_ASSUME_NONNULL_BEGIN

@interface BusStop : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+ (instancetype)insertOrUpdateWithMBusStop:(MBusStop *)busStop;

@end

NS_ASSUME_NONNULL_END

#import "BusStop+CoreDataProperties.h"
