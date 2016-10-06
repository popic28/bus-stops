//
//  ViewController.h
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BusStopsViewModelProtocol;

@interface BusListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

- (void)connectViewModel:(id<BusStopsViewModelProtocol>)viewModel;

@end

