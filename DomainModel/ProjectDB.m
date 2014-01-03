//
//  ProjectDB.m
//  GameAlfa
//
//  Created by lion carp on 6/15/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import "ProjectDB.h"
#import "FMDatabase.h"

@implementation ProjectDB
-(BOOL)CreateTable
{
    @try {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        [database executeUpdate:@"CREATE TABLE Project (id INTEGER  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,ProjectName TEXT(100) DEFAULT NULL,GirlName TEXT(50) DEFAULT NULL,FirstDate Date DEFAULT NULL,Career INTEGER DEFAULT NULL,Rating INTEGER DEFAULT NULL,Intentions integer)"];
        [database close];
        return TRUE;
    }
    @catch (NSException *exception) {
        return FALSE;
    }   
}

-(int) AddNewProject:(Project*) project
{
    int resultId = -1;
    @try {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        [database beginTransaction];
        [database executeUpdate:@"INSERT INTO Project (ProjectName, GirlName, FirstDate, Career, Rating, Intentions) VALUES (?, ?, ?, ?, ?, ?)", [project projectName], [project girlName], [project dateFirstDate],[NSNumber numberWithInt:[project career]], [NSNumber numberWithInt:[project rating]], [NSNumber numberWithInt:[project intentions]], nil];
        
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

-(Project*) getProject:(int) projectId
{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *results = [database executeQuery:@"SELECT * FROM Project where id=	?", [NSString stringWithFormat:@"%i", projectId]];
    Project *project = nil;
    while([results next]) {
        project = [[Project alloc] init];
        project._id = [results intForColumn:@"id"];
        project.projectName = [results stringForColumn:@"ProjectName"];
        project.girlName = [results stringForColumn:@"GirlName"];
        project.career = [results intForColumn:@"Career"];
        project.rating =[results intForColumn:@"Rating"];
        project.intentions = [results intForColumn:@"Intentions"];
        project.dateFirstDate = [results dateForColumn:@"FirstDate"];
    }
    return project;
}

@end
