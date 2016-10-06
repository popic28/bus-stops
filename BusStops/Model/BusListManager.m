//
//  BusListManager.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "BusListManager.h"

#import "AppDelegate.h"
#import <PromiseKit/PromiseKit.h>

#import <Mantle/Mantle.h>
#import "MBusStop.h"
#import "MLineEstimate.h"
#import "BusStop.h"

#import "BusListGetter.h"
#import "BusETAGetter.h"


NSString *const nBusListManagerDidReloadNotification = @"BusListManagerDidReloadNotification";

@interface BusListManager ()

@property (nonatomic, assign)           BOOL refreshing;
@property (nonnull, nonatomic, strong)  NSArray *busList;

@end

@implementation BusListManager

#pragma mark - Public -
- (AnyPromise *)fetchBusListOfZaragoza
{
    if (NO == self.refreshing) {
        [self refreshFromRemote];
    }
    
    if (self.busList != nil)
    {
        return [AnyPromise promiseWithValue:self.busList];
    }
    else
    {
        return [self loadFromDB].then(^{
        
            return [AnyPromise promiseWithValue:self.busList];
        });
    }
}

- (AnyPromise *)arrivalsForBusStopWithID:(NSString *)busID;
{
    return [BusETAGetter estimateArrivalsForBusStopWithID:busID].then(^(NSArray <MLineEstimate *> *estimates){
    
        if ([estimates count] == 1)
        {
            return [AnyPromise promiseWithValue:estimates];
        }
        
        NSArray *sortedEstimates = [estimates sortedArrayUsingComparator:^NSComparisonResult(MLineEstimate *estimate1, MLineEstimate *estimate2)
        {
            if (estimate1.estimate != nil && estimate2.estimate != nil)
            {
                return [estimate1.estimate compare:estimate2.estimate];
            }
            
            return NSOrderedAscending;
        }];
        
        return [AnyPromise promiseWithValue:sortedEstimates];
        
    }).catch(^(NSError *error){
        
        return [AnyPromise promiseWithValue:nil];
    });
}

+ (instancetype)sharedInstance
{
    static BusListManager *busListManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        busListManager = [[self alloc] init];
    });
    
    return busListManager;
}

#pragma mark - Init -
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self refreshFromRemote];
    }
    
    return self;
}

- (void)setBusList:(NSArray *)busList
{
    _busList = busList;
    [[NSNotificationCenter defaultCenter] postNotificationName:nBusListManagerDidReloadNotification object:nil];
}

#pragma mark - Loading -
- (AnyPromise *)loadFromDB
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver  _Nonnull resolve) {
        
        NSError *error = nil;
        NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([BusStop class])];
        NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
        
        if (error)
        {
            resolve(error);
        }
        else
        {
            NSMutableArray *mBusStops = [NSMutableArray array];
            for (BusStop *busStop in results)
            {
                [mBusStops addObject:[MBusStop busStopWithDBBusStop:busStop]];
            }
            
            self.busList = mBusStops;
            resolve(nil);
        }
    }];
}

- (AnyPromise *)loadFromRemote
{
    return [BusListGetter busStopsArray].then(^(NSArray *jsonArray){
        
        return [self busStopsFromBusStopsJSONArray:jsonArray];
    }).then(^(NSArray *busStops){
        
        self.busList = busStops;
    });
}

- (void)refreshFromRemote
{
    self.refreshing = YES;
    [self loadFromRemote].then(^(NSArray *busStops){
        
        [self persistToStore];
        self.refreshing = NO;
    });
}

#pragma mark - Saving -
- (void)persistToStore
{
    for (MBusStop *busStop in self.busList)
    {
        BusStop __unused *persistingBusStop = [BusStop insertOrUpdateWithMBusStop:busStop];
    }
    
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] save:nil];
}

#pragma mark - Mantle -
- (AnyPromise *)busStopsFromBusStopsJSONArray:(NSArray *)jsonArray
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver  _Nonnull resolve) {
        
        NSError *parseError = nil;
        NSArray *parsedList = [MTLJSONAdapter modelsOfClass:[MBusStop class] fromJSONArray:jsonArray error:&parseError];
        
        if (parseError)
        {
            resolve(parseError);
        }
        else
        {
            resolve(parsedList);
        }
    }];
}

@end
