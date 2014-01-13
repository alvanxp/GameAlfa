//
//  CacheManagerDB.h
//  GameAlfa
//
//  Created by lion carp on 1/12/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import "CacheEntity.h"
#import <Foundation/Foundation.h>

@interface CacheManagerDB : NSObject
-(BOOL) CreateTable;
-(int) AddNewCacheManagerItem:(CacheEntity *)cacheManager;
-(CacheEntity*) getCacheManagerByName:(NSString *)name;
@end
