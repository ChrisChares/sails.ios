//
//  SailsSocket.m
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import "SailsSocket.h"
#import "SailsIO.h"

@implementation SailsSocket

/*
+ (SailsIO *)connectToHost:(NSString *)url onPort:(NSInteger)port callback:(SailsIOConnectedBlock)cb
{
    SailsIO *instance = [[SailsIO alloc] init];
    instance.socket = [[SocketIO alloc] initWithDelegate:instance];
    instance.connectedBlock = cb;
    [instance.socket connectToHost:url onPort:port];
    return instance;
}
 */

- (void)get:(NSString *)url data:(id)data callback:(SailsIOBlock)cb
{
    [self request:url data:data callback:cb method:@"get"];
}
- (void)post:(NSString *)url data:(id)data callback:(SailsIOBlock)cb
{
    [self request:url data:data callback:cb method:@"post"];
}
- (void)put:(NSString *)url data:(id)data callback:(SailsIOBlock)cb
{
    [self request:url data:data callback:cb method:@"put"];
}
- (void)delete:(NSString *)url data:(id)data callback:(SailsIOBlock)cb
{
    [self request:url data:data callback:cb method:@"delete"];
}

- (void)request:(NSString *)url data:(id)data callback:(SailsIOBlock)cb method:(NSString *)method
{
    if ( data == nil ) {
        data = @{};
    }
    NSDictionary *payload = @{ @"url" : url,
                               @"data" : data
                               };
    [self.socket sendEvent:method withData:payload andAcknowledge:^(id argsData) {
        
        NSError *error;
        NSData *data = [argsData dataUsingEncoding:NSUTF8StringEncoding];
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if ( error ) {
            NSLog(@"%@", error);
            cb(error, nil);
        } else {
            cb(nil, result);
        }
    }];
    
    
}

#pragma mark - Socket IO
- (void)socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"Connected %@", socket);
    _connected = YES;
    _connectedBlock(socket);
    _connectedBlock = nil;
}

- (void)socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    _connected = NO;
    NSLog(@"Socket error %@", error);
}
- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet
{
    NSLog(@"Received message %@", packet);
}
- (void) socketIO:(SocketIO *)socket didReceiveJSON:(SocketIOPacket *)packet
{
    NSLog(@"Received JSON: %@", packet);
}
- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"Received Event %@", packet);
}
- (void) socketIO:(SocketIO *)socket didSendMessage:(SocketIOPacket *)packet
{
    NSLog(@"Sent message %@", packet);
}
- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{
    NSLog(@"Received Error %@", error);
}


@end
