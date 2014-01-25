//
//  SyntaxHighlightTextStorage.h
//  GameAlfa
//
//  Created by lion carp on 1/15/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyntaxHighlightTextStorage : NSTextStorage
{
        
}
@property (nonatomic,retain) NSDictionary *_replacements;
- (void)update;
@end
