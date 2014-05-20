//
//  SailsIO.h
//  openHouse
//
//  Created by Chris Chares on 5/8/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <socket.IO/SocketIO.h>
#import "SOSRouter.h"
#import "SOSSocket.h"
#import "SOSHTTP.h"
#import "SOSBaseResponseSerializer.h"
#import "SOSTransportProtocol.h"

typedef enum : NSUInteger {
    SOSProtocolHTTP,
    SOSProtocolSockets,
} SOSProtocol;


@interface SailsIOS : NSObject <SOSTransportProtocol>

+ (SailsIOS *)defaultInstance;
+ (void)setDefaultInstance:(SailsIOS *)instance;

- (id)initWithBaseURLString:(NSString *)url;

@property (strong, readonly) NSString *baseURLString;
@property (strong, readonly) NSURL *baseURL;

//optional, default will be provided elsewise
@property SOSRouter *router;

//defaults to SailsProtocolHTTP
@property SOSProtocol defaultProtocol;


@property SOSSocket *socket;
@property SOSHTTP *http;



/*
 In addition to the four methods provided by SailsTransportProtocol, which will use the 
 protocol defined by _defaultProcol, these convenience methods exist to pick either as well
 */

- (void)get:(NSString *)url data:(id)data protocol:(SOSProtocol)protocol callback:(SailsIOBlock)cb;
- (void)post:(NSString *)url data:(id)data protocol:(SOSProtocol)protocol callback:(SailsIOBlock)cb;
- (void)put:(NSString *)url data:(id)data protocol:(SOSProtocol)protocol callback:(SailsIOBlock)cb;
- (void)delete:(NSString *)url data:(id)data protocol:(SOSProtocol)protocol callback:(SailsIOBlock)cb;

//exposed for testing
- (id)requestDataForObject:(id)object;


@end
