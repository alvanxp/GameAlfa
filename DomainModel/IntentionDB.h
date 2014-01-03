//
//  IntentionDB.h
//  GameAlfa
//
//  Created by lion carp on 7/14/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Intention.h"

@interface IntentionDB : NSObject
{
}
-(BOOL) CreateTable;
-(int) AddNewIntention:(Intention*) intention;
-(Intention*) getIntention:(int) intentionId;
@end
