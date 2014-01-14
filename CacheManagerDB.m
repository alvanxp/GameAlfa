//
//  CacheManagerDB.m
//  GameAlfa
//
//  Created by lion carp on 1/12/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import "CacheManagerDB.h"
#import "FMDatabase.h"

@implementation CacheManagerDB

-(id)init
{
    self = [super init];
    if (self)
    {
        [self CreateTable];
    }
    return self;
}

-(BOOL)CreateTable
{
    @try {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        [database executeUpdate:@"CREATE TABLE CacheEntity (id INTEGER  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,Entity TEXT(100) DEFAULT NULL,DownloadDate Date DEFAULT NULL,ExpirationDate Date DEFAULT NULL,Rating INTEGER DEFAULT NULL)"];
        [database close];
        return TRUE;
    }
    @catch (NSException *exception) {
        NSLog(@"Exeption creating CacheEntity table");
        return FALSE;
    }
}

-(void) DeleteItem:(NSString *)entity
{
    int resultId = -1;
    @try {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        [database beginTransaction];
        [database executeUpdate:@"DELETE FROM CacheEntity WHERE Entity = ?", entity, nil];
        
        NSLog(@"Err %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        [database commit];
        [database close];
    }
    @catch (NSException *exception) {
     //   return resultId;
    }
}



-(int)AddNewCacheManagerItem:(CacheEntity *)cacheManager
{
    int resultId = -1;
    @try {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        [database beginTransaction];
        [database executeUpdate:@"INSERT INTO CacheEntity (Entity, DownloadDate, ExpirationDate) VALUES (?, ?, ?)", [cacheManager entity], [cacheManager downloadDate], [cacheManager expirationDate], nil];
        
        NSLog(@"Err %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        [database commit];
        resultId = [database lastInsertRowId];
        [database close];
        return resultId;
    }
    @catch (NSException *exception) {
        return resultId;
    }
    return resultId;
}

-(CacheEntity*) getCacheManagerByName:(NSString *)name
{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *results = [database executeQuery:@"SELECT * FROM CacheEntity where Entity=	?", name];
    CacheEntity *cacheManager = nil;
    while([results next]) {
        cacheManager = [[CacheEntity alloc] init];
        cacheManager._id = [results intForColumn:@"id"];
        cacheManager.entity = [results stringForColumn:@"Entity"];
        cacheManager.downloadDate = [results dateForColumn:@"DownloadDate"];
        cacheManager.expirationDate = [results dateForColumn:@"ExpirationDate"];
        
    }
    return cacheManager;
}
@end
