//
//  SailsRouterTests.m
//  sails.ios
//
//  Created by Chris on 5/14/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SailsRouter.h"
#import <AFNetworking/AFNetworking.h>
#import <SOCKit/SOCKit.h>

#define route1 @"/event/:id/timeline"
#define route2 @"/user/:id/events"
#define route3 @"/agent/:id/events"

@interface SailsRouterTests : XCTestCase
@property SailsRouter *router;
@end

@implementation SailsRouterTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    
    _router = [[SailsRouter alloc] initWithRoutes:@{route1: [AFJSONResponseSerializer serializer],
                                                    route2: [AFHTTPResponseSerializer serializer],
                                                    route3: [AFXMLParserResponseSerializer serializer]
                                                    }];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



- (void)testReturnsTypeSOCPattern
{
    id object = [[[_router.routes keyEnumerator] allObjects] firstObject];
    expect(object).to.beKindOf([SOCPattern class]);
}

- (void)testMatchFirstRoute
{
    id responseSerializer = [_router responseSerializerForURL:@"/event/12/timeline"];
    expect(responseSerializer).notTo.beNil;
}

- (void)testFirstRouteReturnsJSON
{
    id responseSerializer = [_router responseSerializerForURL:@"/event/12/timeline"];
    expect(responseSerializer).to.beKindOf([AFJSONResponseSerializer class]);
}

- (void)testMatchesSecondRoute
{
    id responseSerializer = [_router responseSerializerForURL:@"/user/1/events"];
    expect(responseSerializer).notTo.beNil;

}

- (void)testSecondRouteReturnsHTTP
{
    id responseSerializer = [_router responseSerializerForURL:@"/user/1/events"];
    expect(responseSerializer).to.beKindOf([AFHTTPResponseSerializer class]);

}

- (void)testRouterHasADefault
{
    id responseSerializer = [_router responseSerializerForURL:@"/not/a/real/route"];
    expect(responseSerializer).notTo.beNil;
}


@end
