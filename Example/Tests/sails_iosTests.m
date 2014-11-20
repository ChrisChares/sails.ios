//
//  sails_iosTests.m
//  sails.iosTests
//
//  Created by Chris on 5/13/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SailsIOS.h"

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
    expect(_sails).notTo.beNil;
}

- (void)testSetDefaultsWorks
{
    [SailsIOS setDefaultInstance:_sails];
    expect([SailsIOS defaultInstance]).notTo.beNil;
}
- (void)testSailsSocketsNotNil
{
    expect(_sails.socket).notTo.beNil;
}

- (void)testSailsHTTPNotNil
{
    expect(_sails.http).notTo.beNil;
}

@end
