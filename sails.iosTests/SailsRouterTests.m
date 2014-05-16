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
#define route2 @"/event/:id/feed"
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
    id object = [[[_router.routes keyEnumerator] allObjects] objectAtIndex:0];
    XCTAssert([[[_router.routes keyEnumerator] allObjects] isKindOfClass:[SOCPattern class]], @"Router isn't returning types of socpatterns");
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
