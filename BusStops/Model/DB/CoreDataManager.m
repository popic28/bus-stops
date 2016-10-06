//
//  CoreDataStackManager.m
//  BusStops
//
//  Created by Florian Popa on 10/6/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "CoreDataManager.h"

#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Constants.h"

@interface CoreDataManager ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CoreDataManager

#pragma mark - Public -
+ (instancetype)sharedInstance
{
    static CoreDataManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSManagedObject *)createNewObjectForEntity:(Class)entityClass;
{
    NSAssert([entityClass isSubclassOfClass:[NSManagedObject class]], @"cannot insert an entity that is not of a managedObject subclass");
   id object = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(entityClass)
                                             inManagedObjectContext:self.managedObjectContext];
    return object;
}

- (void)deleteObject:(NSManagedObject *)object
{
    NSAssert(object!=nil, @"cannot delete a nil object");
    [self.managedObjectContext deleteObject:object];
}

- (NSArray <NSManagedObject *>*)allObjectsForEntity:(Class)entityClass error:(NSError *__autoreleasing *)error
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass(entityClass)];
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:error];

    return results;
}

- (void)save
{
    [self saveContext];
}

#pragma mark - CoreData Stack -
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[Constants kCoreDataModelName] withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *storeURL = [[Constants applicationDocumentsDirectory] URLByAppendingPathComponent:[Constants kCoreDataStore_URL]];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:[Constants kErrorDomain] code:CoreDataManagerErrorCodeFailedToLoadStore userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator)
    {
        return nil;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    [_managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support
- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
