//
//  MockModel.m
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import "MockModel.h"

@implementation MockModel

+ (id)testOne
{
    MockModel *m = [[MockModel alloc] init];
    m.name = @"Darth Vadar";
    m.title = @"Head Custodian";
    return m;
    
}

+ (id)testTwo
{
    MockModel *m = [[MockModel alloc] init];
    m.name = @"Jar Jar Binks";
    m.title = @"Senior Statesman";
    return m;
}




- (NSDictionary *)toDictionary
{
    return @{@"name" : self.name,
             @"title" : self.title};
}

+ (id)fromDictionary:(NSDictionary *)dictionary
{
    MockModel *m = [[MockModel alloc] init];
    m.name = dictionary[@"name"];
    m.title = dictionary[@"title"];
    return m;
}
@end
