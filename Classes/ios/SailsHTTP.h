//
//  SailsHTTP.h
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "SailsTransportProtocol.h"

@class SailsIO;
@interface SailsHTTP : AFHTTPSessionManager <SailsTransportProtocol>

@property (weak, nonatomic) SailsIO *sails;

@end
