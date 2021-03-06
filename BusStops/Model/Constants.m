//
//  Constants.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "Constants.h"

@implementation Constants

+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSString *)kErrorDomain
{
    return @"error.BusStops";
}

+ (NSString *)kBUS_API_URL
{    
    return @"http://api.dndzgz.com/services/bus";
}

+ (NSString *)kMaps_API_URL
{
    return @"https://maps.googleapis.com/maps/api/staticmap";
}

+ (NSString *)kMaps_API_KEY
{
    return @"AIzaSyAmoSiOsIPiVz2I5MVNmHCh15dMXJyJetA";
}

+ (NSDictionary *)kMaps_DefaultParams
{
    return @{ @"zoom" : @(18),
              @"scale": @(2),
              @"size" : @"640x640",
              @"maptype" : @"roadmap" };
}

+ (NSString *)kCoreDataModelName
{
    return @"BusStops";
}

+ (NSString *)kCoreDataStore_URL
{
    return @"BusStops.sqlite";
}

@end
