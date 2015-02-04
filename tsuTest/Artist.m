//
//  Artist.m
//  tsuTest
//
//  Created by Andrey on 2/3/15.
//  Copyright (c) 2015 Svetliy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Artist.h"

@implementation Artist

@synthesize title;
@synthesize desc;
@synthesize img;
@synthesize createdAt;


-(id)initWithTitle:(NSString *)str{
    self = [super init];
    if(self)
    {
        self.title = str;
    }
    return self;
}

@end
