//
//  SailsSerializable.h
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SailsSerializable <NSObject>


@required
- (NSDictionary *)toDictionary;
+ (id)fromDictionary:(NSDictionary *)dictionary;

@end
