//
//  Enlatado.m
//  GameAlfa
//
//  Created by lion carp on 1/4/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import "Enlatado.h"

@implementation Enlatado
@synthesize _id;
@synthesize title;
@synthesize description;
@synthesize rating;
@synthesize resume;

+(Enlatado*) noteWithText:(NSString *)title detail:(NSString *)detailText resume:(NSString *)resumeText
{
    Enlatado *enlatado = [Enlatado new];
    enlatado.title = title;
    enlatado.description = detailText;
    enlatado.resume = resumeText;
    return enlatado;
}

@end
