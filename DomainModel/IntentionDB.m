//
//  IntentionDB.m
//  GameAlfa
//
//  Created by lion carp on 7/14/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import "IntentionDB.h"
#import "FMDatabase.h"
@implementation IntentionDB
-(BOOL)CreateTable
{
    @try {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        [database executeUpdate:@"CREATE TABLE Intention (id INTEGER  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,Name TEXT(100) DEFAULT NULL)"];
        [database close];
        return TRUE;
    }
    @catch (NSException *exception) {
        return FALSE;
    }
  
}

-(int) AddNewIntention:(Intention*) project
{
    int resultId = -1;
    @try {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        [database beginTransaction];
        [database executeUpdate:@"INSERT INTO Intention (Name) VALUES (?)", [project name], nil];
        
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

-(Intention*) getIntention:(int) intentionId
{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *results = [database executeQuery:@"SELECT * FROM Intention where id=	?", [NSString stringWithFormat:@"%i", intentionId]];
    Intention *project = nil;
    while([results next]) {
        project = [[Intention alloc] init];
        project._id = [results intForColumn:@"id"];
        project.name = [results stringForColumn:@"Name"];
    }
    return project;
}


@end
