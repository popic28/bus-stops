//
//  BusStopsViewItem.h
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusStopsViewModelProtocol.h"
#import <UIKit/UIKit.h>
@class MBusStop;

@interface BusStopsViewItem : NSObject <BusStopViewItemProtocol>

@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *nextBusDescription;
@property (nonatomic, copy) UIImage  *thumbnail;

+(instancetype)loadFromBusStop:(MBusStop *)busStop;

@end
