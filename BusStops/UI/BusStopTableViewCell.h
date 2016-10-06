//
//  BusStopTableViewCell.h
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BusStopViewItemProtocol;

@interface BusStopTableViewCell : UITableViewCell

- (void)populateWithViewItem:(id<BusStopViewItemProtocol>)viewItem;

@end
