//
//  BusListGetterTest.m
//  BusStops
//
//  Created by Florian Popa on 10/6/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BusListGetter.h"
#import "BusETAGetter.h"
#import "ThumbnailGetter.h"
#import "MBusStop.h"
#import "MLineEstimate.h"

#import <PromiseKit/PromiseKit.h>

@interface GetterTests : XCTestCase

@end

@implementation GetterTests

- (void)testBusListGetting {
    
    [BusListGetter busStopsArray]
    .then(^(NSArray *busStops) {
        
        XCTAssertNotNil(busStops);
    })
    .catch(^{
    
        XCTAssert(NO);
    });
}

- (void)testBusETAGetting
{
    [BusListGetter busStopsArray]
    .then(^(NSArray *busStops) {
        
        return [BusETAGetter estimateArrivalsForBusStopWithID:[(MBusStop *)[busStops firstObject] busID]];
    })
    .then(^(NSArray *busStops) {
        
        XCTAssertNotNil(busStops);
    });
}

- (void)testThumbnailGetting {
    
    [ThumbnailGetter mapThumbnailWithLat:@(45) lon:@(0)].then(^(UIImage *thumb){
    
        XCTAssertNotNil(thumb);
    });
}

@end
