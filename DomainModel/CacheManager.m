//
//  CacheManager.m
//  GameAlfa
//
//  Created by lion carp on 1/12/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import "CacheManager.h"
#import "CacheManagerDB.h"
#import "EnlatadoDB.h"
@implementation CacheManager
static CacheManager *sharedInstance = nil;
CacheManagerDB *cacheEntity = nil;
EnlatadoDB *enlatadoManager = nil;

+(CacheManager *)sharedInstance{
    
    if (sharedInstance == nil)
        sharedInstance = [[super allocWithZone:NULL] init];
    return sharedInstance;
}

-(CacheManagerDB *) entityManager{
    if (cacheEntity == nil)
    {
        cacheEntity = [[CacheManagerDB alloc] init];
    }
    return cacheEntity;
}

-(EnlatadoDB *) enlatadoManager{
    if (enlatadoManager == nil)
    {
        enlatadoManager = [[EnlatadoDB alloc] init];
    }
    return enlatadoManager;
}
@end
