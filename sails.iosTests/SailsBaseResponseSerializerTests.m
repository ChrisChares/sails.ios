//
//  SailsBaseResponseSerializerTests.m
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SailsBaseResponseSerializer.h"
#import <OHHTTPStubs.h>
#import <OHHTTPStubsResponse+JSON.h>
#import "MockUser.h"
#import "SailsIO.h"
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

@interface SailsBaseResponseSerializerTests : XCTestCase

@property SailsBaseResponseSerializer *serializer;

@property MockUser *testModel1;
@property MockUser *testModel2;

@property SailsIO *sails;

@property id result;

@end

@implementation SailsBaseResponseSerializerTests

- (void)setUp
{
    [super setUp];
    
    _sails = [[SailsIO alloc] initWithBaseURLString:@"http://www.google.com"];
    _serializer = [[SailsBaseResponseSerializer alloc] init];
    
    _testModel1 = [MockUser testOne];
    _testModel2 = [MockUser testTwo];
    
    [Expecta setAsynchronousTestTimeout:5.0];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        
        return [OHHTTPStubsResponse responseWithJSONObject:[_testModel1 toDictionary] statusCode:200 headers:@{}];
        
    }];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _serializer = nil;
    [OHHTTPStubs removeAllStubs];
    _result = nil;
    [super tearDown];
}


/*
 Test the SailsSerializable Interface
 */
- (void)testModelBecomesDictionary
{
    expect([_testModel1 toDictionary]).toNot.beNil();
}
- (void)testModelBecomesPropertyDictionary
{
    NSDictionary *test = [_testModel1 toDictionary];
    expect(test[@"email"]).to.equal(_testModel1.email);
}
- (void)testDictionaryBecomesModel
{
    NSDictionary *test = [_testModel2 toDictionary];
    expect([MockUser fromDictionary:test]).toNot.beNil();
}
- (void)testDictionaryBecomesProperModel
{
    NSDictionary *test = [_testModel2 toDictionary];
    MockUser *conv = [MockUser fromDictionary:test];
    expect(conv.email).to.equal(test[@"email"]);
}

/*
 Test the serializer itself
 */

- (void)testNotNil
{
    XCTAssertNotNil(_serializer, @"Serializer can't be nil");
}

- (void)testStatusCodesPos
{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:200];
    XCTAssertTrue([_serializer.acceptableStatusCodes containsIndexes:set], @"It should accept a status code of 200");
}

- (void)testStatusCodesNeg
{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:500];
    XCTAssertFalse([_serializer.acceptableStatusCodes containsIndexes:set], @"It should not accept a status code of 500");
}


- (void)testAcceptsJson
{
    XCTAssertTrue([_serializer.acceptableContentTypes containsObject:@"application/json"], @"It should accept application/json");
}

- (void)testRejectsHtml
{
    XCTAssertFalse([_serializer.acceptableContentTypes containsObject:@"text/html"], @"It should reject text/html");
}


- (void)testDictionaryInDictionaryOut
{
    
    __block id responseObject;
    [_sails get:@"/" data:nil callback:^(NSError *error, id response) {
        NSLog(@"response %@", response);
        responseObject = response;
    }];
    
    expect(responseObject).willNot.beNil();
}


- (void)testCustomRouteSerializer
{
    SailsBaseResponseSerializer *serializer = [[SailsBaseResponseSerializer alloc] init];
    serializer.modelClass = [MockUser class];
    
    SailsRouter *router = [[SailsRouter alloc] initWithRoutes:@{@"/event/:id/content": serializer}];
    _sails.router = router;
    
 //   __block id responseObject;
    [_sails get:@"/event/12/content" data:nil callback:^(NSError *error, id response) {
        NSLog(@"Error %@ Response %@", error, response);
        _result = response;
       // expect(false).to.equal(true);


    }];
    expect(_result).willNot.beNil();
    expect(_result).will.beKindOf([MockUser class]);

    
}
@end
