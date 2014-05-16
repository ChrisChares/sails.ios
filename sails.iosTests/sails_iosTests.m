//
//  sails_iosTests.m
//  sails.iosTests
//
//  Created by Chris on 5/13/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SailsIO.h"

@interface sails_iosTests : XCTestCase

@property SailsIO *sails;
@end

@implementation sails_iosTests

- (void)setUp
{
    [super setUp];
    
    _sails = [[SailsIO alloc] initWithBaseURLString:@"http://localhost"];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSailsExists
{
    XCTAssertNotNil(_sails,  @"Singleton getter isn't working");
   // XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testSetDefaultsWorks
{
    [SailsIO setDefaultInstance:_sails];
    XCTAssertNotNil([SailsIO defaultInstance], @"Default instance is null");
}
- (void)testSailsSocketsNotNil
{
    XCTAssertNotNil(_sails.socket, @"Socket is nil");
}

- (void)testSailsHTTPNotNil
{
    XCTAssertNotNil(_sails.http, @"http is nil");
}

@end
