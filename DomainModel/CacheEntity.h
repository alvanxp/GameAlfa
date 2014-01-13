//
//  CacheManager.h
//  GameAlfa
//
//  Created by lion carp on 1/12/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheEntity : NSObject
@property (nonatomic, assign) int _id;
@property (nonatomic,retain) NSString* entity;
@property (nonatomic,retain) NSDate* downloadDate;
@property (nonatomic,retain) NSDate* expirationDate;

@end
