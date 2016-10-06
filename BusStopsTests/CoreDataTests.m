//
//  CoreDataTests.m
//  BusStops
//
//  Created by Florian Popa on 10/6/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataManager+Testable.h"
#import "BusStop.h"

@interface CoreDataTests : XCTestCase

@end

@implementation CoreDataTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateNewEntry {
    
    id busStop = [[CoreDataManager sharedInstance] createNewObjectForEntity:[BusStop class]];
    XCTAssertNotNil(busStop);
}

- (void)testGetObjects
{
    BusStop *newEntry = (BusStop *)[[CoreDataManager sharedInstance] createNewObjectForEntity:[BusStop class]];
    newEntry.busID = [[NSProcessInfo processInfo] globallyUniqueString];
    
    NSError *err;
    NSArray *busStops = [[CoreDataManager sharedInstance] allObjectsForEntity:[BusStop class] error:&err];
    
    XCTAssertNil(err);
    XCTAssertTrue([busStops count] > 0);
}

- (void)testDeleteObject
{
    NSError *err;
    NSArray *busStops = [[CoreDataManager sharedInstance] allObjectsForEntity:[BusStop class] error:&err];
    XCTAssertNil(err);
    
    NSUInteger count = [busStops count];
    
    BusStop *newEntry = (BusStop *)[[CoreDataManager sharedInstance] createNewObjectForEntity:[BusStop class]];
    newEntry.busID = [[NSProcessInfo processInfo] globallyUniqueString];
    
    [[CoreDataManager sharedInstance] deleteObject:newEntry];
    
    busStops = [[CoreDataManager sharedInstance] allObjectsForEntity:[BusStop class] error:&err];
    
    XCTAssertTrue(count == [busStops count]);
}

@end
