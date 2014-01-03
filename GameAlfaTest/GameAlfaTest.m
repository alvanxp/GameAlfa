//
//  GameAlfaTest.m
//  GameAlfaTest
//
//  Created by lion carp on 6/15/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import "GameAlfaTest.h"
#import "ProjectDB.h"
static int projectId = 0;
@implementation GameAlfaTest
- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testNotNullProjectDB
{
    ProjectDB *projectDb = [[ProjectDB alloc] init];
    STAssertNotNil(projectDb, @"is not expected");
}

- (void)testCreateDB
{
    ProjectDB *projectDb = [[ProjectDB alloc] init];
    BOOL result = [projectDb CreateTable];
    STAssertEquals(result, YES, @"DB is not create");
} 

- (void)testInsertProject
{
    Project *newProject = [[Project alloc] init];
    [newProject setProjectName:@"New Project"];
    [newProject setGirlName:@"Julia"];
    [newProject setCareer:1];
    [newProject setRating:1];
    [newProject setIntentions:1];
    [newProject setDateFirstDate:[[NSDate alloc] init]];    
    ProjectDB *projectDb = [[ProjectDB alloc] init];
    
    projectId = [projectDb AddNewProject:newProject];
    BOOL compare = (projectId > 0);
    STAssertEquals(compare, YES, @"Project Register is not create");
}

- (void)testzGetProject
{
    ProjectDB *projectDb = [[ProjectDB alloc] init];
    Project *project = [projectDb getProject:projectId];
    STAssertNotNil(project, @"project is null");
    STAssertEquals(project._id, projectId, @"Project Register is not create");
}

@end
