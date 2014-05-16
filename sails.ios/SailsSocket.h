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

@property SocketIO *socket;
@property BOOL connected;

- (SailsIO *)connectToHost:(NSString *)url onPort:(NSInteger)port callback:(SailsIOConnectedBlock)cb;

@property (strong) SailsIOConnectedBlock connectedBlock;
@property (strong) SailsIODisconnectedBlock disconnectedBlock;

@end
