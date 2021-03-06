//
//  Constants.h
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

+ (NSURL *)applicationDocumentsDirectory;

+ (NSString *)kErrorDomain;

+ (NSString *)kBUS_API_URL;

+ (NSString *)kMaps_API_URL;
+ (NSString *)kMaps_API_KEY;
+ (NSDictionary *)kMaps_DefaultParams;

+ (NSString *)kCoreDataModelName;
+ (NSString *)kCoreDataStore_URL;

@end
