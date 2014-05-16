//
//  SailsBaseResponseSerializerTests.m
//  sails.ios
//
//  Created by Chris Chares on 5/15/14.
//  Copyright (c) 2014 eunoia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SailsBaseResponseSerializer.h"

@interface SailsBaseResponseSerializerTests : XCTestCase

@property SailsBaseResponseSerializer *serializer;

@property NSDictionary *testModel1;
@property NSDictionary *testModel2;

@end

@implementation SailsBaseResponseSerializerTests

- (void)setUp
{
    [super setUp];
    
    _serializer = [[SailsBaseResponseSerializer alloc] init];
    _testModel1 = @{@"name": @"Jabba the Hutt", @"title" : @"Directory of Sexy"};
    _testModel2 = @{@"name": @"Greedo", @"title": @"Junior Bounty Hunter"};
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _serializer = nil;

    [super tearDown];
}

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
    NSError *error;
    id data = [NSJSONSerialization dataWithJSONObject:_testModel1 options:0 error:&error];
    [_serializer responseObjectForResponse: data:<#(NSData *)#> error:<#(NSError *__autoreleasing *)#>]
}
@end
