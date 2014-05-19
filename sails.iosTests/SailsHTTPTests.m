//
//  SailsHTTPTests.m
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHHTTPStubsResponse+JSON.h>
#import "SailsIO.H"
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "MockUser.h"

@interface SailsHTTPTests : XCTestCase

@property SailsIO *sails;

@property MockUser *testModel;

@end

@implementation SailsHTTPTests

- (void)setUp
{
    [super setUp];
    
    _sails = [[SailsIO alloc] initWithBaseURLString:@"http://google.com"];
    _testModel = [MockUser testOne];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        
        return [OHHTTPStubsResponse responseWithJSONObject:[_testModel toDictionary] statusCode:200 headers:@{}];
    
    }];
}

- (void)tearDown
{
    [OHHTTPStubs removeAllStubs];
    [super tearDown];
}

- (void)testMockData
{
    
    __block BOOL test = false;
    
    [_sails get:@"/" data:nil callback:^(NSError *error, id response) {
        test = YES;
    }];
    
    expect(test).willNot.equal(false);
//    expect(_error).will.beNil();

}

@end
