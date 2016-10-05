//
//  NSURLSession+Promise.h
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AnyPromise;

@interface NSURLSession (Promise)

+ (AnyPromise *)dataPromiseWithURLString:(NSString *)urlString;

+ (AnyPromise *)downloadPromiseWithRequest:(NSURLRequest *)request;

@end
