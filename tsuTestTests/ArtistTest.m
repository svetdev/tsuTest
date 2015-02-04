//
//  ArtistTest.m
//  tsuTest
//
//  Created by Andrey on 2/3/15.
//  Copyright (c) 2015 Svetliy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Artist.h"


@interface ArtistTest : XCTestCase

@end

@implementation ArtistTest

- (void)setUp {
    [super setUp];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testInitIwthTitleArtistMatch {
    Artist *newArtist = [[Artist alloc] initWithTitle:@"Test-title-should-match"];
    
    if ([newArtist.title isEqualToString:@"Test-title-should-match"]){
         XCTAssert(YES, @"Pass");
    } else {
         XCTAssert(NO, @"Not Pass");
    }
}


@end
