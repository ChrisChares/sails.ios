//
//  sails_iosTests.m
//  sails.iosTests
//
//  Created by Chris on 5/13/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SailsIOS.h"
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "MockUser.h"

@interface sails_iosTests : XCTestCase

@property SailsIOS *sails;
@end

@implementation sails_iosTests

- (void)setUp
{
    [super setUp];
    
    _sails = [[SailsIOS alloc] initWithBaseURLString:@"http://localhost"];
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
    [SailsIOS setDefaultInstance:_sails];
    XCTAssertNotNil([SailsIOS defaultInstance], @"Default instance is null");
}
- (void)testSailsSocketsNotNil
{
    XCTAssertNotNil(_sails.socket, @"Socket is nil");
}

- (void)testSailsHTTPNotNil
{
    XCTAssertNotNil(_sails.http, @"http is nil");
}

- (void)testSocketNotNil
{
    expect(_sails.socket.socket).toNot.beNil();
}

- (void)testDictionaryPassthrough
{
    NSDictionary *testDictionary = @{@"derp" : @"double derp"};
    expect([_sails requestDataForObject:testDictionary]).to.beKindOf([NSDictionary class]);
}

- (void)testMockObjectConversion
{
    MockUser *user = [MockUser testOne];
    expect([_sails requestDataForObject:user]).to.beKindOf([NSDictionary class]);
}

@end
