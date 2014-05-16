//
//  MockModel.m
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import "MockModel.h"

@implementation MockModel


- (NSDictionary *)toDictionary
{
    return @{@"name" : @"title"};
}

+ (id)fromDictionary:(NSDictionary *)dictionary
{
    MockModel *m = [[MockModel alloc] init];
    m.name = dictionary[@"name"];
    m.title = dictionary[@"title"];
    return m;
}
@end
