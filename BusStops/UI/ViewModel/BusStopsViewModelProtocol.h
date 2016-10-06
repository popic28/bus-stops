//
//  BusStopsViewModelProtocol.h
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

@protocol BusStopViewItemProtocol <NSObject>
- (NSString *)number;
- (NSString *)title;
- (NSString *)subtitle;
- (NSString *)nextBusDescription;
- (UIImage *)thumbnail;
@end

@protocol BusStopsViewModelDelegate <NSObject>
- (void)viewModelDidUpdateItemAtIndex:(NSUInteger)index;
- (void)viewModelDidUpdateAllItems;
@end

@protocol BusStopsViewModelProtocol <NSObject>
@property (nonatomic, weak) id<BusStopsViewModelDelegate> delegate;
- (NSUInteger)numberOfViewItems;
- (id<BusStopViewItemProtocol>)viewItemAtIndex:(NSUInteger)index;
- (void)fetchEstimatesForIndex:(NSUInteger)index;
@end
