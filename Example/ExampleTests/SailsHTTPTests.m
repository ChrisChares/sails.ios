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
#import "SailsIOS.h"
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "MockUser.h"

@interface SailsHTTPTests : XCTestCase

@property SailsIOS *sails;

@property MockUser *testModel;

@end

@implementation SailsHTTPTests

- (void)setUp
{
    [super setUp];
    
    _sails = [[SailsIOS alloc] initWithBaseURLString:@"http://localhost:1337"];
    _sails.defaultProtocol = SOSProtocolHTTP;
    
    _testModel = [MockUser testTwo];
    
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreateUser
{
    
    __block id responseObject;
    [_sails post:@"/user" data:_testModel callback:^(NSError *error, id response) {
       
        responseObject = response;
        
    }];
    
    expect(responseObject).willNot.beNil();
}

/*
- (void)testMockData
{
    
    __block BOOL test = false;
    
    [_sails get:@"/" data:nil callback:^(NSError *error, id response) {
        test = YES;
    }];
    
    expect(test).willNot.equal(false);
//    expect(_error).will.beNil();

}
 */

@end
