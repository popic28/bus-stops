//
//  Constants.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "Constants.h"

@implementation Constants

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
    return @{ @"zoom" : @(12),
              @"scale": @(2),
              @"size" : @"200x200",
              @"maptype" : @"roadmap" };
}

@end
