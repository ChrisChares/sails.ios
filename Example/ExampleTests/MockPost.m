//
//  MockPost.m
//  sails.ios
//
//  Created by Chris Chares on 5/19/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import "MockPost.h"

@implementation MockPost


- (NSDictionary *)toDictionary
{
    
    return @{@"title" : self.title};
}

+ (id)fromDictionary:(NSDictionary *)dictionary
{
    MockPost *post = [[MockPost alloc] init];
    post.title = dictionary[@"title"];
    return post;
}
@end
