//
//  SailsHTTP.h
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "SOSTransportProtocol.h"

@class SailsIOS;
@interface SOSHTTP : AFHTTPSessionManager <SOSTransportProtocol>

@property (weak, nonatomic) SailsIOS *sails;

@end
