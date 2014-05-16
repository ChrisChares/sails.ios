//
//  SailsHTTPTests.m
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "SailsIO.H"

@interface SailsHTTPTests : XCTestCase

@property SailsIO *sails;

@end

@implementation SailsHTTPTests

- (void)setUp
{
    [super setUp];
    
    _sails = [[SailsIO alloc] initWithBaseURLString:@"http://google.com"];

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:@{@"Name": @"Dildo"} options:0 error:&error];
        return [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:@{@"Content-Type": @"text/json"}];
    
    }];
}

- (void)tearDown
{
    [OHHTTPStubs removeAllStubs];
    [super tearDown];
}

- (void)testSomethingStupid
{
    [_sails get:@"/" data:nil callback:^(NSError *error, id response) {
        XCTAssertNotNil(nil, @"balls in yo face");
        XCTAssertNotNil(error, @"Google shouldn't be returning valid json, this should error out");
    }];
}

@end
