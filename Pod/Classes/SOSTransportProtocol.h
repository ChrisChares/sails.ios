//
//  SailsTransportProtocol.h
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SailsIOBlock)(NSError *error, id response);


@protocol SOSTransportProtocol <NSObject>

@required
- (void)get:(NSString *)url data:(id)data callback:(SailsIOBlock)cb;
- (void)post:(NSString *)url data:(id)data callback:(SailsIOBlock)cb;
- (void)put:(NSString *)url data:(id)data callback:(SailsIOBlock)cb;
- (void)delete:(NSString *)url data:(id)data callback:(SailsIOBlock)cb;


@end
