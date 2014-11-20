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
#import "MockModel.h"
#import "SailsIO.h"

@interface SailsBaseResponseSerializerTests : XCTestCase

@property SailsBaseResponseSerializer *serializer;

@property MockModel *testModel1;
@property MockModel *testModel2;

@property SailsIO *sails;

@property id result;

@end

@implementation SailsBaseResponseSerializerTests

- (void)setUp
{
    [super setUp];
    
    _sails = [[SailsIO alloc] initWithBaseURLString:@"http://www.google.com"];
    _serializer = [[SailsBaseResponseSerializer alloc] init];
    
    _testModel1 = [MockModel testOne];
    _testModel2 = [MockModel testTwo];
    
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
    expect(test[@"name"]).to.equal(_testModel1.name);
}
- (void)testDictionaryBecomesModel
{
    NSDictionary *test = [_testModel2 toDictionary];
    expect([MockModel fromDictionary:test]).toNot.beNil();
}
- (void)testDictionaryBecomesProperModel
{
    NSDictionary *test = [_testModel2 toDictionary];
    MockModel *conv = [MockModel fromDictionary:test];
    expect(conv.name).to.equal(test[@"name"]);
}

/*
 Test the serializer itself
 */

- (void)testNotNil
{
    expect(_serializer).toNot.beNil;
}

- (void)testStatusCodesPos
{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:200];
    expect([_serializer.acceptableStatusCodes containsIndexes:set]).to.beTruthy;
}

- (void)testStatusCodesNeg
{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:500];
    expect([_serializer.acceptableStatusCodes containsIndexes:set]).toNot.beTruthy;
}


- (void)testAcceptsJson
{
    expect([_serializer.acceptableContentTypes containsObject:@"application/json"]).to.beTruthy;
}

- (void)testRejectsHtml
{
    expect([_serializer.acceptableContentTypes containsObject:@"text/html"]).toNot.beTruthy;
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
    serializer.modelClass = [MockModel class];
    
    SailsRouter *router = [[SailsRouter alloc] initWithRoutes:@{@"/event/:id/content": serializer}];
    _sails.router = router;
    
 //   __block id responseObject;
    [_sails get:@"/event/12/content" data:nil callback:^(NSError *error, id response) {
        NSLog(@"Error %@ Response %@", error, response);
        _result = response;
       // expect(false).to.equal(true);


    }];
    expect(_result).willNot.beNil();
    expect(_result).will.beKindOf([MockModel class]);

    
}
@end
