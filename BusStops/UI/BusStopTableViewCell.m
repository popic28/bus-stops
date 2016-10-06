//
//  BusStopTableViewCell.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "BusStopTableViewCell.h"

#import "BusStopsViewModelProtocol.h"

@interface BusStopTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *busStopIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *busStopTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *busStopSubtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *busStopNextBusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *busStopThumbnail;
@end

@implementation BusStopTableViewCell

- (void)populateWithViewItem:(id<BusStopViewItemProtocol>)viewItem
{
    self.busStopIDLabel.text = viewItem.number;
    self.busStopTitleLabel.text = viewItem.title;
    self.busStopSubtitleLabel.text = viewItem.subtitle;
    self.busStopNextBusLabel.text = viewItem.nextBusDescription;
    
    if (nil != viewItem.thumbnail)
    {
        [self.busStopThumbnail setImage:viewItem.thumbnail];
    }
}

@end
