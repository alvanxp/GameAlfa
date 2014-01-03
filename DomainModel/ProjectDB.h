//
//  ProjectDB.h
//  GameAlfa
//
//  Created by lion carp on 6/15/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
@interface ProjectDB : NSObject
{
    
}
-(BOOL) CreateTable;
-(int) AddNewProject:(Project*) project;
-(Project*) getProject:(int) projectId;
@end

