//
//  Level.h
//  GameAlfa
//
//  Created by lion carp on 8/4/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject
@property (nonatomic, assign) int _id;
@property (nonatomic,retain) NSString* name;
@property (assign, readwrite) NSMutableArray *steps;
@property (nonatomic, assign) int projectid;
@end
