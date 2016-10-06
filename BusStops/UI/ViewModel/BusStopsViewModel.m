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
        
        viewItem.nextBusDescription = [NSString stringWithFormat:@"%@ > %@\n   %lu min",
                                       nextArrival.name,
                                       nextArrival.direction,
                                       [nextArrival.estimate unsignedIntegerValue]];
        
        [self.delegate viewModelDidUpdateItemAtIndex:[self.busStopViewItems indexOfObject:viewItem]];
    });
}

@end
