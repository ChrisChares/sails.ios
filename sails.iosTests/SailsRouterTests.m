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
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

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
    NSLog(@"shit %@", [object class]);
    expect(object).to.beKindOf([SOCPattern class]);
}

- (void)testMatchFirstRoute
{
    id responseSerializer = [_router responseSerializerForURL:@"/event/12/timeline"];
    XCTAssert(responseSerializer, @"No serializer returned for a valid route");
}

- (void)testFirstRouteReturnsJSON
{
    id responseSerializer = [_router responseSerializerForURL:@"/event/12/timeline"];
    XCTAssert([responseSerializer isKindOfClass:[AFJSONResponseSerializer class]], @"JSON serializer not returned for first route");
}

- (void)testMatchesSecondRoute
{
    id responseSerializer = [_router responseSerializerForURL:@"/user/1/events"];
    XCTAssert(responseSerializer, @"No serializer returned for a valid route");

}

- (void)testSecondRouteReturnsHTTP
{
    id responseSerializer = [_router responseSerializerForURL:@"/user/1/events"];
    XCTAssert([responseSerializer isKindOfClass:[AFHTTPResponseSerializer class]], @"HTTP serializer not returned for first second route");
}

- (void)testRouterHasADefault
{
    id responseSerializer = [_router responseSerializerForURL:@"/not/a/real/route"];
    XCTAssertNotNil(responseSerializer, @"default serializer not returned for a fake route");
}


@end
