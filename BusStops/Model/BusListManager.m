//
//  BusListManager.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "BusListManager.h"

#import <PromiseKit/PromiseKit.h>
#import "Constants.h"
#import "NSURLSession+Promise.h"

#import <Mantle/Mantle.h>
#import "MBusStop.h"


NSString *const nBusListManagerDidReloadNotification = @"BusListManagerDidReloadNotification";

@interface BusListManager ()

@property (nonnull, nonatomic, strong) NSArray *busList;

@end

@implementation BusListManager

#pragma mark - Init -
+ (instancetype)sharedInstance
{
    static BusListManager *busListManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        busListManager = [[self alloc] init];
    });
    
    return busListManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self loadFromRemote].then(^(NSArray *busStops){
            
            [self persistToStore];
        });
    }
    
    return self;
}

- (void)persistToStore
{
    //TODO: persist to CD
}

#pragma mark - Networking -
- (AnyPromise *)loadFromRemote
{
    return [NSURLSession dataPromiseWithURLString:[Constants kBUS_API_URL]].then(^id(NSData *data) {
        
        NSError *parseError = nil;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        if (parseError) {
            return parseError;
        }
        
        NSArray *busStopsJSONArray = [self busListArrayFromBusListDict:jsonData];
        
        return [self busStopsFromBusStopsJSONArray:busStopsJSONArray];
        
    }).then(^(NSArray <MBusStop *>* busStopsArray){
        
        self.busList = busStopsArray;
        
        return [AnyPromise promiseWithValue:self.busList];
    });
}

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

- (NSArray *)busListArrayFromBusListDict:(NSDictionary *)busListDict
{
    return [busListDict objectForKey:@"locations"];
}




#pragma mark - Public -
- (AnyPromise *)fetchBusListOfZaragoza
{
    if (self.busList != nil)
    {
        return [AnyPromise promiseWithValue:self.busList];
    }
    else
    {
        //TODO: try to fetch from CD first
    }
    
    return [self loadFromRemote];
}

@end
