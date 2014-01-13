//
//  TipoEnlatado.h
//  GameAlfa
//
//  Created by lion carp on 1/5/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TipoEnlatado : NSObject
@property (nonatomic, assign) int _id;
@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) NSString* description;
@property (nonatomic, retain) NSArray* enlatados;
@end
