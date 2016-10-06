//
//  BusStopsViewModel.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "BusStopsViewModel.h"

#import "ThumbnailManager.h"
#import "BusListManager.h"
#import "MBusStop.h"
#import "MLineEstimate.h"

#import "BusStopsViewItem.h"

#import <PromiseKit/PromiseKit.h>


@interface BusStopsViewModel ()
@property (nonatomic, strong) NSArray <BusStopsViewItem *> *busStopViewItems;
@property (nonatomic, strong) NSDictionary *busStopsDict;
@end

@implementation BusStopsViewModel
@synthesize delegate = _delegate;

#pragma mark - Init -
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(busStopsDidUpdate) name:nBusListManagerDidReloadNotification object:nil];
        [self loadData];
    }
    
    return self;
}

- (void)loadData
{
    [[BusListManager sharedInstance] fetchBusListOfZaragoza].then(^(NSArray <MBusStop *>*busStops){
    
        NSMutableArray *viewItemsArray = [NSMutableArray array];
        NSMutableDictionary *busStopsDict = [NSMutableDictionary dictionary];
        for (MBusStop *busStop in busStops)
        {
            [viewItemsArray addObject:[BusStopsViewItem loadFromBusStop:busStop]];
            [busStopsDict setObject:busStop forKey:busStop.busID];
        }
        
        self.busStopsDict = busStopsDict;
        self.busStopViewItems = viewItemsArray;
        
        [self.delegate viewModelDidUpdateAllItems];
        
    }).catch(^(NSError *error) {
        
        NSLog(@"error:%@",error);
    });
}

#pragma mark - BusStopsViewModelProtocol -
- (NSUInteger)numberOfViewItems
{
    return [self.busStopViewItems count];
}

- (id<BusStopViewItemProtocol>)viewItemAtIndex:(NSUInteger)index
{
    BusStopsViewItem *viewItem = [self.busStopViewItems objectAtIndex:index];
    
    if (viewItem.nextBusDescription == nil)
    {
        [self fetchEstimatesForIndex:index];
    }
    
    if (viewItem.thumbnail == nil)
    {
        [ThumbnailManager busStopImageWithBusStop:[self.busStopsDict objectForKey:viewItem.number] shouldCacheOnDisk:YES].then(^(UIImage *image){
            
            viewItem.thumbnail = image;
            
            [self.delegate viewModelDidUpdateItemAtIndex:[self.busStopViewItems indexOfObject:viewItem]];
            
        }).catch(^(NSError *error) {
            
            NSLog(@"error:%@",error);
        });
    }
    
    return viewItem;
}

- (void)fetchEstimatesForIndex:(NSUInteger)index
{
    BusStopsViewItem *viewItem = [self.busStopViewItems objectAtIndex:index];
    
    [[BusListManager sharedInstance] arrivalsForBusStopWithID:viewItem.number]
    .then(^(NSArray <MLineEstimate *>*sortedEstimates) {
        
        MLineEstimate *nextArrival = [sortedEstimates firstObject];
        if (nil == nextArrival)
        {
            return;
        }
        viewItem.nextBusDescription = [self arrivalDescriptionWithName:nextArrival.name
                                                             direction:nextArrival.direction
                                                                  time:[nextArrival.estimate unsignedIntegerValue]];
        
        [self.delegate viewModelDidUpdateItemAtIndex:[self.busStopViewItems indexOfObject:viewItem]];
        
    }).catch(^(NSError *error) {
        
        NSLog(@"error:%@",error);
    });
}

#pragma mark - Notifications -
- (void)busStopsDidUpdate
{
    [self loadData];
}

#pragma mark - Helpers -
- (NSString *)arrivalDescriptionWithName:(NSString *)name direction:(NSString *)direction time:(NSUInteger)time
{
    return [NSString stringWithFormat:@"%@ > %@\n   %lu min",name,direction,time];
}

@end
