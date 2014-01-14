//
//  EnlatadoDB.h
//  GameAlfa
//
//  Created by lion carp on 1/12/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enlatado.h"
@interface EnlatadoDB : NSObject
{}

-(BOOL) CreateTable;
-(int) AddNewEnlatado:(Enlatado*) enlatado;
-(Enlatado*) getEnlatado:(int) enlatadoId;
-(NSArray*) getEnlatados;
-(void) deleteItems;
@end
