//
//  NSURLSession+Promise.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "NSURLSession+Promise.h"
#import <PromiseKit/PromiseKit.h>

@implementation NSURLSession (Promise)

+ (AnyPromise *)dataPromiseWithURLString:(NSString *)urlString
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver  _Nonnull resolve) {
        
        NSURLSessionDataTask *dataTask =
        [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString]
                                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
         {
             if (error)
             {
                 resolve(error);
             }
             else
             {
                 resolve(data);
             }
             
         }];
        
        [dataTask resume];
    }];
}


@end
