//
//  SailsRouter.m
//  sails.ios
//
//  Created by Chris on 5/14/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import "SailsRouter.h"

@implementation SailsRouter

- (id)initWithRoutes:(NSDictionary *)routes
{
    self = [super init];
    if ( self ) {
        
        NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
        
        for ( NSString *key in routes.allKeys ) {
            SOCPattern *pattern = [SOCPattern patternWithString:key];
            [mapTable setObject:routes[key] forKey:pattern];
        }
        
        _routes = mapTable;
        
    }
    
    return self;
}


@end
