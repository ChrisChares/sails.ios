//
//  SailsIO.m
//  openHouse
//
//  Created by Chris Chares on 5/8/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import "SailsIO.h"
#import "SailsSerializable.h"

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
        _socket = [[SailsSocket alloc] initWithSails:self];
        _http = [[SailsHTTP alloc] initWithBaseURL:_baseURL]; _http.sails = self;
        _router = [[SailsRouter alloc] initWithRoutes:@{}];
        _defaultProtocol = SailsProtocolHTTP;
        
    }
    
    return self;
}


/*
 Whoop all the fun methods
 */
- (id)requestDataForObject:(id)object
{
    if ( [object isKindOfClass:[NSDictionary class]] || [object isKindOfClass:[NSMutableDictionary class]]) {
        return object;
    } else if ( [[object class] conformsToProtocol:@protocol(SailsSerializable) ]) {
        return [object toDictionary];
    } else {
        NSLog(@"Request data object must either be a dictionary or a class that conforms to SailsSerializable");
        return nil;
    }
}
- (void)get:(NSString *)url data:(id)data protocol:(SailsProtocol)protocol callback:(SailsIOBlock)cb
{
    id requestData = [self requestDataForObject:data];
    if ( protocol == SailsProtocolSockets ) {
        [self.socket get:url data:requestData callback:cb];
    } else {
        [self.http get:url data:requestData callback:cb];
    }
}

- (void)post:(NSString *)url data:(id)data protocol:(SailsProtocol)protocol callback:(SailsIOBlock)cb
{
    id requestData = [self requestDataForObject:data];
    if ( protocol == SailsProtocolSockets ) {
        [self.socket post:url data:requestData callback:cb];
    } else {
        [self.http post:url data:requestData callback:cb];
    }
}

- (void)put:(NSString *)url data:(id)data protocol:(SailsProtocol)protocol callback:(SailsIOBlock)cb
{
    id requestData = [self requestDataForObject:data];
    if ( protocol == SailsProtocolSockets ) {
        [self.socket put:url data:requestData callback:cb];
    } else {
        [self.http put:url data:requestData callback:cb];
    }
}

- (void)delete:(NSString *)url data:(id)data protocol:(SailsProtocol)protocol callback:(SailsIOBlock)cb
{
    id requestData = [self requestDataForObject:data];
    if ( protocol == SailsProtocolSockets ) {
        [self.socket delete:url data:requestData callback:cb];
    } else {
        [self.http delete:url data:requestData callback:cb];
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
