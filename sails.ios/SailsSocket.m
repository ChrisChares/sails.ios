//
//  SailsSocket.m
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import "SailsSocket.h"
#import "SailsIO.h"

#define DEFAULT_MAX_RECONNECT_ATTEMPTS 3


@interface SailsSocket()

@property NSString *host;
@property NSInteger port;

@property NSInteger reconnectAttempts;
@property NSInteger maxReconnectAttempts;
@end


@implementation SailsSocket

- (id)init
{
    self = [super init];
    if ( self ) {
        self.socket = [[SocketIO alloc] initWithDelegate:self];
        NSURL *baseURL = _sails.baseURL;
        _host = [baseURL host];
        _port = [[baseURL port] integerValue];
        if ( ! _port ) {
            NSLog(@"No port specified for socket connection, defaulting to 80");
            _port = 80;
        }
        
        _maxReconnectAttempts = DEFAULT_MAX_RECONNECT_ATTEMPTS;
    }
    return self;
}

- (void)connect
{

    [self.socket connectToHost:_host onPort:_port];

}

- (void)disconnect
{
    [self.socket disconnect];
}

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
    _connectedBlock(socket);
    _connectedBlock = nil;
}

- (void)socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"Socket error %@\nAttempting reconnect %d of %d", error, _reconnectAttempts + 1, _maxReconnectAttempts);

    if ( _reconnectAttempts < _maxReconnectAttempts ) {
        [self connect];
    }
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
