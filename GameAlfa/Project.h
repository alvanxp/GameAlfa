//
//  Project.h
//  GameAlfa
//
//  Created by lion carp on 6/15/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject
@property (nonatomic, assign) int _id;
@property (nonatomic,retain) NSString* projectName;
@property (nonatomic, retain) NSString* girlName;
@property (nonatomic, retain) NSDate* dateFirstDate;
@property (nonatomic, assign) int career;
@property (nonatomic, assign) int rating;
@property(nonatomic, assign) int intentions;
@property (assign, readwrite) NSMutableArray *levels;
@end
