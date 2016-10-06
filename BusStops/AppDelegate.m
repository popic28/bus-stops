//
//  AppDelegate.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "AppDelegate.h"

#import "BusListViewController.h"
#import "BusStopsViewModel.h"
#import "CoreDataManager.h"

@interface AppDelegate ()
@property (nonnull, nonatomic, strong) BusStopsViewModel *viewModel;
@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.viewModel = [[BusStopsViewModel alloc] init];
    
    [(BusListViewController *)self.window.rootViewController connectViewModel:self.viewModel];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[CoreDataManager sharedInstance] save];
}

@end
