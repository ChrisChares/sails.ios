//
//  SailsHTTP.m
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import "SailsHTTP.h"
#import "SailsIO.h"
@implementation SailsHTTP

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if ( self ) {
        self.requestSerializer = [AFJSONRequestSerializer new];
    }
    return self;
}

- (void)get:(NSString *)url data:(id)data callback:(SailsIOBlock)cb
{
    NSLog(@"Requesting url %@ with data %@", url, data);
    self.responseSerializer = [_sails.router responseSerializerForURL:url];
    NSURLSessionDataTask *task =  [self GET:url
                                 parameters:data
                                    success:^(NSURLSessionDataTask *task, id responseObject) {
                                        NSLog(@"Received response for [url][%@] %@", url, responseObject);
                                        cb(nil, responseObject);
                                    }
                                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        NSLog(@"Received error for [ur][%@] %@", url, error);
                                        cb(error, nil);
                                    }];
    [task resume];
}
- (void)post:(NSString *)url data:(id)data callback:(SailsIOBlock)cb
{
    NSLog(@"Requesting url %@ with data %@", url, data);
    self.responseSerializer = [_sails.router responseSerializerForURL:url];
    NSURLSessionDataTask *task =  [self POST:url
                                 parameters:data
                                    success:^(NSURLSessionDataTask *task, id responseObject) {
                                        NSLog(@"Received response for [url][%@] %@", url, responseObject);
                                        cb(nil, responseObject);
                                    }
                                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        NSLog(@"Received error for [ur][%@] %@", url, error);
                                        cb(error, nil);
                                    }];
    [task resume];
}
- (void)put:(NSString *)url data:(id)data callback:(SailsIOBlock)cb
{
    NSLog(@"Requesting url %@ with data %@", url, data);
    self.responseSerializer = [_sails.router responseSerializerForURL:url];
    NSURLSessionDataTask *task =  [self PUT:url
                                 parameters:data
                                    success:^(NSURLSessionDataTask *task, id responseObject) {
                                        NSLog(@"Received response for [url][%@] %@", url, responseObject);
                                        cb(nil, responseObject);
                                    }
                                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        NSLog(@"Received error for [ur][%@] %@", url, error);
                                        cb(error, nil);
                                    }];
    [task resume];
}
- (void)delete:(NSString *)url data:(id)data callback:(SailsIOBlock)cb
{
    NSLog(@"Requesting url %@ with data %@", url, data);
    self.responseSerializer = [_sails.router responseSerializerForURL:url];
    NSURLSessionDataTask *task =  [self DELETE:url
                                 parameters:data
                                    success:^(NSURLSessionDataTask *task, id responseObject) {
                                        NSLog(@"Received response for [url][%@] %@", url, responseObject);
                                        cb(nil, responseObject);
                                    }
                                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        NSLog(@"Received error for [ur][%@] %@", url, error);
                                        cb(error, nil);
                                    }];
    [task resume];
}



@end
