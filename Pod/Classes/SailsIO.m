//
//  SailsIO.m
//  openHouse
//
//  Created by Chris Chares on 5/8/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import "SailsIO.h"
@interface SailsIO()



@end


@implementation SailsIO


static SailsIO *instance;
+ (SailsIO *)defaultInstance
{
    return instance;
}
+ (void)setDefaultInstance:(SailsIO *)anInstance
{
    instance = anInstance;
}

- (id)initWithBaseURLString:(NSString *)url
{
    self = [super init];
    if ( self ) {
        
        _baseURLString = url;
        _baseURL = [NSURL URLWithString:url];
        _socket = [[SailsSocket alloc] init]; _socket.sails = self;
        _http = [[SailsHTTP alloc] initWithBaseURL:_baseURL]; _http.sails = self;
        _router = [[SailsRouter alloc] initWithRoutes:@{}];
        _defaultProtocol = SailsProtocolHTTP;
        
    }
    
    return self;
}


/*
 Whoop all the fun methods
 */

- (void)get:(NSString *)url data:(id)data protocol:(SailsProtocol)protocol callback:(SailsIOBlock)cb
{
    if ( protocol == SailsProtocolSockets ) {
        [self.socket get:url data:data callback:cb];
    } else {
        [self.http get:url data:data callback:cb];
    }
}

- (void)post:(NSString *)url data:(id)data protocol:(SailsProtocol)protocol callback:(SailsIOBlock)cb
{
    if ( protocol == SailsProtocolSockets ) {
        [self.socket post:url data:data callback:cb];
    } else {
        [self.http post:url data:data callback:cb];
    }
}

- (void)put:(NSString *)url data:(id)data protocol:(SailsProtocol)protocol callback:(SailsIOBlock)cb
{
    if ( protocol == SailsProtocolSockets ) {
        [self.socket put:url data:data callback:cb];
    } else {
        [self.http put:url data:data callback:cb];
    }
}

- (void)delete:(NSString *)url data:(id)data protocol:(SailsProtocol)protocol callback:(SailsIOBlock)cb
{
    if ( protocol == SailsProtocolSockets ) {
        [self.socket delete:url data:data callback:cb];
    } else {
        [self.http delete:url data:data callback:cb];
    }
}

- (void)get:(NSString *)url data:(id)data callback:(SailsIOBlock)cb
{
    [self get:url data:data protocol:_defaultProtocol callback:cb];
}
- (void)post:(NSString *)url data:(id)data callback:(SailsIOBlock)cb
{
    [self post:url data:data protocol:_defaultProtocol callback:cb];
}
- (void)put:(NSString *)url data:(id)data callback:(SailsIOBlock)cb
{
    [self put:url data:data protocol:_defaultProtocol callback:cb];
}
- (void)delete:(NSString *)url data:(id)data callback:(SailsIOBlock)cb
{
    [self delete:url data:data protocol:_defaultProtocol callback:cb];
}
@end
