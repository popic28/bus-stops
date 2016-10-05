//
//  BusStop+CoreDataProperties.h
//  
//
//  Created by Florian Popa on 10/5/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BusStop.h"

NS_ASSUME_NONNULL_BEGIN

@interface BusStop (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *subtitle;
@property (nullable, nonatomic, retain) NSNumber *lat;
@property (nullable, nonatomic, retain) NSNumber *lon;
@property (nullable, nonatomic, retain) NSArray  *lines;

@end

NS_ASSUME_NONNULL_END
