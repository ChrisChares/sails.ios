//
//  MockModel.m
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import "MockUser.h"

@implementation MockUser

+ (id)testOne
{
    MockUser *m = [[MockUser alloc] init];
    m.email = @"anakin@deathstar.com";
    return m;
    
}

+ (id)testTwo
{
    MockUser *m = [[MockUser alloc] init];
    m.email = @"jarjar@naboo.com";
    return m;
}




- (NSDictionary *)toDictionary
{
    return @{@"email" : self.email};
}

+ (id)fromDictionary:(NSDictionary *)dictionary
{
    MockUser *m = [[MockUser alloc] init];
    m.email = dictionary[@"email"];
    return m;
}
@end
