//
//  SailsRouter.h
//  sails.ios
//
//  Created by Chris on 5/14/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <SOCKit/SOCKit.h>


@interface SailsRouter : NSObject


- (id)initWithRoutes:(NSDictionary *)routes;

@property (strong, readonly) NSMapTable *routes;

- (BOOL)urlMatchesAnyRoute:(NSString *)url;
- (AFHTTPResponseSerializer *)responseSerializerForURL:(NSString *)url;

@end
