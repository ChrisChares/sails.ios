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
        _defaultResponseSerializer = [[AFJSONResponseSerializer alloc] init];
        
    }
    
    return self;
}


- (AFHTTPResponseSerializer *)responseSerializerForURL:(NSString *)url
{
    
    NSArray *keys = [[_routes keyEnumerator] allObjects];
    for ( SOCPattern *pattern in keys) {
        
        if ( [pattern stringMatches:url] ) {
            id responseSerializer = [_routes objectForKey:pattern];
            NSLog(@"Matched route for url: %@\nPattern: %@\nResponse Serializer: %@", url, pattern, responseSerializer);
            return responseSerializer;
        }
        
    }
    
    NSLog(@"No route matched for url %@, returning default serializer %@", url, _defaultResponseSerializer);
    return _defaultResponseSerializer;
    
    
}


@end
