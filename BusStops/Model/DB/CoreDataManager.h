//
//  CoreDataStackManager.h
//  BusStops
//
//  Created by Florian Popa on 10/6/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObject;

typedef NS_ENUM(NSUInteger, CoreDataManagerErrorCode) {
    CoreDataManagerErrorCodeFailedToLoadStore = 1,
};

@interface CoreDataManager : NSObject

+ (instancetype)sharedInstance;

- (NSManagedObject *)createNewObjectForEntity:(Class)entityClass;
- (void)deleteObject:(NSManagedObject *)object;
- (NSArray <NSManagedObject *>*)allObjectsForEntity:(Class)entityClass error:(NSError **)error;

- (void)save;

@end
