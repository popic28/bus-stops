//
//  NSURLSession+Promise.m
//  BusStops
//
//  Created by Florian Popa on 10/5/16.
//  Copyright © 2016 Florin Popa. All rights reserved.
//

#import "NSURLSession+Promise.h"
#import <PromiseKit/PromiseKit.h>
#import <OMGHTTPURLRQ/OMGHTTPURLRQ.h>
#import <UIKit/UIKit.h>

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

+ (AnyPromise *)downloadPromiseWithRequest:(NSURLRequest *)request
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver  _Nonnull resolve) {
    
        NSURLSessionDownloadTask *downloadTask =
        [[NSURLSession sharedSession] downloadTaskWithRequest:request
                                            completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
         {
             NSData *dataFromFile = [NSData dataWithContentsOfURL:location];
             
             UIImage *image = [UIImage imageWithData:dataFromFile];
             
             resolve(image);
         }];
        
        [downloadTask resume];
    }];
}

@end
