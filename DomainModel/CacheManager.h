//
//  CacheManager.h
//  GameAlfa
//
//  Created by lion carp on 1/12/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//
#import "CacheManagerDB.h"
#import "EnlatadoDB.h"
#import <Foundation/Foundation.h>

@interface CacheManager : NSObject
+(CacheManager *)sharedInstance;
-(CacheManagerDB *) entityManager;
-(EnlatadoDB *) enlatadoManager;
@end
