//
//  SailsIO.h
//  openHouse
//
//  Created by Chris Chares on 5/8/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <socket.IO/SocketIO.h>
#import "SailsRouter.h"
#import "SailsSocket.h"
#import "SailsHTTP.h"
#import "SailsBaseResponseSerializer.h"
#import "SailsTransportProtocol.h"

typedef enum : NSUInteger {
    SailsProtocolHTTP,
    SailsProtocolSockets,
} SailsProtocol;



@interface SailsIO : NSObject <SailsTransportProtocol>

+ (SailsIO *)defaultInstance;
+ (void)setDefaultInstance:(SailsIO *)instance;

- (id)initWithBaseURLString:(NSString *)url;

@property (strong, readonly) NSString *baseURLString;
@property (strong, readonly) NSURL *baseURL;

//optional, default will be provided elsewise
@property SailsRouter *router;

//defaults to SailsProtocolHTTP
@property SailsProtocol defaultProtocol;


@property SailsSocket *socket;
@property SailsHTTP *http;



/*
 In addition to the four methods provided by SailsTransportProtocol, which will use the 
 protocol defined by _defaultProcol, these convenience methods exist to pick either as well
 */

- (void)get:(NSString *)url data:(id)data protocol:(SailsProtocol)protocol callback:(SailsIOBlock)cb;
- (void)post:(NSString *)url data:(id)data protocol:(SailsProtocol)protocol callback:(SailsIOBlock)cb;
- (void)put:(NSString *)url data:(id)data protocol:(SailsProtocol)protocol callback:(SailsIOBlock)cb;
- (void)delete:(NSString *)url data:(id)data protocol:(SailsProtocol)protocol callback:(SailsIOBlock)cb;



@end
