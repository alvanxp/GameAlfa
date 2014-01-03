//
//  IntentionTest.m
//  GameAlfa
//
//  Created by lion carp on 7/15/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import "IntentionTest.h"
#import "Intention.h"
#import "IntentionDB.h"
static int projectId = 0;
@implementation IntentionTest
- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testNotNullIntentionDB
{
    IntentionDB *projectDb = [[IntentionDB alloc] init];
    STAssertNotNil(projectDb, @"is not expected");
}

- (void)testCreateDB
{
    IntentionDB *intentionDb = [[IntentionDB alloc] init];
    BOOL result = [intentionDb CreateTable];
    STAssertEquals(result, YES, @"DB is not create");
}

- (void)testInsertIntention
{
    Intention *newProject = [[Intention alloc] init];
    [newProject setName:@"Torcerle el pescueso"];
    
    IntentionDB *projectDb = [[IntentionDB alloc] init];
    projectId = [projectDb AddNewIntention:newProject];
    BOOL compare = (projectId > 0);
    STAssertEquals(compare, YES, @"Intention Register is not create");
}

- (void)testzGetIntention
{
    IntentionDB *projectDb = [[IntentionDB alloc] init];
    Intention *project = [projectDb getIntention:projectId];
    STAssertNotNil(project, @"Intention is null");
    STAssertEquals(project._id, projectId, @"Intention Register is not create");
}


@end
