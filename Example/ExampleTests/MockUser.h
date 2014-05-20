//
//  MockModel.h
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOSSerializable.h"

@interface MockUser : NSObject <SOSSerializable>




+ (id)testOne;
+ (id)testTwo;


@property NSString *email;





@end
