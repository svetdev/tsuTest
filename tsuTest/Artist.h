//
//  Artist.h
//  tsuTest
//
//  Created by Andrey on 2/3/15.
//  Copyright (c) 2015 Svetliy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * img;
@property (nonatomic, retain) NSDate * createdAt;

-(id)initWithTitle:(NSString *)str;
@end
