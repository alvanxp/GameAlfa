//
//  EnlatadoDB.m
//  GameAlfa
//
//  Created by lion carp on 1/12/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import "EnlatadoDB.h"
#import "Enlatado.h"
#import "FMDatabase.h"
@implementation EnlatadoDB

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
        [database executeUpdate:@"CREATE TABLE Enlatado (id INTEGER  PRIMARY KEY AUTOINCREMENT DEFAULT NULL,Title TEXT(100) DEFAULT NULL,Description TEXT(500) DEFAULT NULL, Resume TEXT(300) DEFAULT NULL, Rating INTEGER DEFAULT NULL)"];
        [database close];
        return TRUE;
    }
    @catch (NSException *exception) {
        return FALSE;
    }
    
}

-(void) deleteItems
{
    @try {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        [database beginTransaction];
        [database executeUpdate:@"DELETE FROM Enlatado", nil];
        
        NSLog(@"Err %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        [database commit];
        [database close];
    }
    @catch (NSException *exception) {
        //   return resultId;
    }
}

-(void) DeleteItem:(NSString *)entity
{
    @try {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        [database beginTransaction];
        [database executeUpdate:@"DELETE FROM CacheEntity ", nil];
        
        NSLog(@"Err %d: %@", [database lastErrorCode], [database lastErrorMessage]);
        [database commit];
        [database close];
    }
    @catch (NSException *exception) {
        //   return resultId;
    }
}

-(int)AddNewEnlatado:(Enlatado *)enlatado
{
    int resultId = -1;
    @try {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
        [database open];
        [database beginTransaction];
        [database executeUpdate:@"INSERT INTO Enlatado (Title, Description, Resume, Rating) VALUES (?, ?, ?, ?)", [enlatado title], [enlatado description], [enlatado resume],[NSNumber numberWithInt:[enlatado rating]], nil];
        
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

-(Enlatado*) getEnlatado:(int)enlatadoId
{
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *results = [database executeQuery:@"SELECT * FROM Enlatado where id=	?", [NSString stringWithFormat:@"%i", enlatadoId]];
    Enlatado *enlatado = nil;
    while([results next]) {
        enlatado = [[Enlatado alloc] init];
        enlatado._id = [results intForColumn:@"id"];
        enlatado.title = [results stringForColumn:@"Title"];
        enlatado.description = [results stringForColumn:@"Description"];
        enlatado.resume = [results stringForColumn:@"Resume"];
        enlatado.rating =[results intForColumn:@"Rating"];
    }
    return enlatado;
}

-(NSArray *) getEnlatados
{
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"GameAlfa.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *results = [database executeQuery:@"SELECT * FROM Enlatado"];
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    while([results next]) {
        Enlatado *enlatado = [[Enlatado alloc] init];
        enlatado._id = [results intForColumn:@"id"];
        enlatado.title = [results stringForColumn:@"Title"];
        enlatado.description = [results stringForColumn:@"Description"];
        enlatado.resume = [results stringForColumn:@"Resume"];
        enlatado.rating =[results intForColumn:@"Rating"];
        [temp addObject:enlatado];
    }
    NSArray *result = [NSArray arrayWithArray:temp];
    return result;
}

@end
