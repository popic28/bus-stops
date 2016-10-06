//
//  ViewController.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "BusListViewController.h"
#import "BusStopsViewModelProtocol.h"
#import "BusStopTableViewCell.h"


NSString *const kBusStopReuseID = @"BusStopReuseID";


@interface BusListViewController () <BusStopsViewModelDelegate>

@property (nonatomic, weak) id<BusStopsViewModelProtocol> viewModel;

@end


@implementation BusListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (nil == self.viewModel)
    {
        NSLog(@"no view model, no data");
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(updateVisibleCells) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)connectViewModel:(id<BusStopsViewModelProtocol>)viewModel
{
    self.viewModel = viewModel;
    self.viewModel.delegate = self;
}

- (void)updateVisibleCells
{
    for (NSIndexPath *indexPath in [self.tableView indexPathsForVisibleRows])
    {
        [self.viewModel fetchEstimatesForIndex:indexPath.row];
    }
}

#pragma mark - BusStopsViewModelDelegate -
- (void)viewModelDidUpdateAllItems
{
    [self.tableView reloadData];
}

- (void)viewModelDidUpdateItemAtIndex:(NSUInteger)index
{
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfViewItems];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusStopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBusStopReuseID];
    
    [cell populateWithViewItem:[self.viewModel viewItemAtIndex:indexPath.row]];
    
    return cell;
}

@end
