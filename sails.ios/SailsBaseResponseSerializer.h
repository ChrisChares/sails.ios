//
//  SailsBaseResponseSerializer.h
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <AFNetworking/AFURLResponseSerialization.h>


/*
 
 I should be subclassed in implementations, returning domain specific models instead of generic json
 */


@interface SailsBaseResponseSerializer : AFJSONResponseSerializer


//SUBCLASS ME YO
- (id)modelForDictionary:(NSDictionary *)dictionary;

//use obj c reflection to perform generic mappings?
//-(void)performGenericMappings;

@end
