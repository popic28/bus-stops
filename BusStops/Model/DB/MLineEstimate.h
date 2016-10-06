//
//  MLineEstimate.h
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MLineEstimate : MTLModel <MTLJSONSerializing>

@property (nonnull, nonatomic, copy) NSString *name;
@property (nonnull, nonatomic, copy) NSString *direction;
@property (nonnull, nonatomic, copy) NSNumber *estimate;

@end