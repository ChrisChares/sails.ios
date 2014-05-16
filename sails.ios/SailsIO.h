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


typedef void(^SailsIOBlock)(NSError *error, id response);
typedef void(^SailsIOConnectedBlock)(SocketIO *socket);
typedef void(^SailsIODisconnectedBlock)(NSError *error, SocketIO *socket);

@interface SailsIO : NSObject <SocketIODelegate>

+ (SailsIO *)connectToHost:(NSString *)url onPort:(NSInteger)port callback:(SailsIOConnectedBlock)cb;

//optional
@property SailsRouter *router;

@property SocketIO *socket;
@property BOOL connected;
@property (strong) SailsIOConnectedBlock connectedBlock;

- (void)get:(NSString *)url data:(id)data callback:(SailsIOBlock)cb;
- (void)post:(NSString *)url data:(id)data callback:(SailsIOBlock)cb;
- (void)put:(NSString *)url data:(id)data callback:(SailsIOBlock)cb;
- (void)delete:(NSString *)url data:(id)data callback:(SailsIOBlock)cb;


@end
