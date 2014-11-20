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
#import "MockModel.h"

@interface SailsHTTPTests : XCTestCase

@property SailsIO *sails;

@property MockModel *testModel;

@end

@implementation SailsHTTPTests

- (void)setUp
{
    [super setUp];
    
    _sails = [[SailsIO alloc] initWithBaseURLString:@"http://google.com"];
    _testModel = [MockModel testOne];
    
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

- (void)testUsesJSONRequestSerializer {
    expect(_sails.http.requestSerializer).to.beKindOf([AFJSONRequestSerializer class]);
           
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
