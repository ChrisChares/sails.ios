//
//  SailsSocket.h
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <socket.IO/SocketIO.h>
//#import "SailsIO.h"
#import "SailsTransportProtocol.h"

@class SailsIO;

typedef void(^SailsIOConnectedBlock)(SocketIO *socket);
typedef void(^SailsIODisconnectedBlock)(NSError *error, SocketIO *socket);

@interface SailsSocket : NSObject <SocketIODelegate, SailsTransportProtocol>

@property (weak, nonatomic) SailsIO *sails;

@property (strong, readonly) SocketIO *socket;

@property (strong, readonly) NSString *host;
@property (readonly) NSInteger port;

- (id)initWithSails:(SailsIO *)sails;

- (void)connect;
- (void)disconnect;

@property (strong) SailsIOConnectedBlock connectedBlock;
@property (strong) SailsIODisconnectedBlock disconnectedBlock;

@end
