//
//  SyntaxHighlightTextStorage.m
//  GameAlfa
//
//  Created by lion carp on 1/15/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import "SyntaxHighlightTextStorage.h"

@implementation SyntaxHighlightTextStorage
{
    NSMutableAttributedString *_backingStore;
    
}

@synthesize _replacements;
- (id)init
{
    if (self = [super init]) {
        _backingStore = [NSMutableAttributedString new];
        [self createHighlightPatterns];
    }
    return self;
}

- (NSDictionary*)createAttributesForFontStyle:(NSString*)style
                                    withTrait:(uint32_t)trait {
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor
                                        preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    
    UIFontDescriptor *descriptorWithTrait = [fontDescriptor
                                             fontDescriptorWithSymbolicTraits:trait];
    
    UIFont* font =  [UIFont fontWithDescriptor:descriptorWithTrait size: 0.0];
    return @{ NSFontAttributeName : font };
}

- (void)applyStylesToRange:(NSRange)searchRange
{
    NSDictionary* normalAttrs = @{NSFontAttributeName:
                                      [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    
   
    
    // iterate over each replacement
    for (NSString* key in _replacements) {
        NSRegularExpression *regex = [NSRegularExpression
                                      regularExpressionWithPattern:key
                                      options:0
                                      error:nil];
        
        NSDictionary* attributes = _replacements[key];
        
        [regex enumerateMatchesInString:[_backingStore string]
                                options:0
                                  range:searchRange
                             usingBlock:^(NSTextCheckingResult *match,
                                          NSMatchingFlags flags,
                                          BOOL *stop){
                                 // apply the style
                                 NSRange matchRange = [match rangeAtIndex:1];
                                 [self addAttributes:attributes range:matchRange];
                                 
                                 // reset the style to the original
                                 if (NSMaxRange(matchRange)+1 < self.length) {
                                     [self addAttributes:normalAttrs
                                                   range:NSMakeRange(NSMaxRange(matchRange)+1, 1)];
                                 }
                             }];
    }
}

-(void)update {
    // update the highlight patterns
    [self createHighlightPatterns];
    
    // change the 'global' font
    NSDictionary* bodyFont = @{NSFontAttributeName :
                                   [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    [self addAttributes:bodyFont
                  range:NSMakeRange(0, self.length)];
    
    // re-apply the regex matches
    [self applyStylesToRange:NSMakeRange(0, self.length)];
}

- (NSString *)string
{
    return [_backingStore string];
}

-(void)processEditing
{
    [self performReplacementsForRange:[self editedRange]];
    [super processEditing];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location
                     effectiveRange:(NSRangePointer)range
{
    return [_backingStore attributesAtIndex:location
                             effectiveRange:range];
}

- (void)performReplacementsForRange:(NSRange)changedRange
{
    NSRange extendedRange = NSUnionRange(changedRange, [[_backingStore string]
                                                        lineRangeForRange:NSMakeRange(changedRange.location, 0)]);
    extendedRange = NSUnionRange(changedRange, [[_backingStore string]
                                                lineRangeForRange:NSMakeRange(NSMaxRange(changedRange), 0)]);
    [self applyStylesToRange:extendedRange];
}

- (void) createHighlightPatterns {
    UIFontDescriptor *scriptFontDescriptor =
    [UIFontDescriptor fontDescriptorWithFontAttributes:
     @{UIFontDescriptorFamilyAttribute: @"Zapfino"}];
    
    // 1. base our script font on the preferred body font size
    UIFontDescriptor* bodyFontDescriptor = [UIFontDescriptor
                                            preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    NSNumber* bodyFontSize = bodyFontDescriptor.
    fontAttributes[UIFontDescriptorSizeAttribute];
    UIFont* scriptFont = [UIFont
                          fontWithDescriptor:scriptFontDescriptor size:[bodyFontSize floatValue]];
    
    // 2. create the attributes
    NSDictionary* boldAttributes = [self
                                    createAttributesForFontStyle:UIFontTextStyleBody
                                    withTrait:UIFontDescriptorTraitBold];
    NSDictionary* italicAttributes = [self
                                      createAttributesForFontStyle:UIFontTextStyleBody
                                      withTrait:UIFontDescriptorTraitItalic];
    NSDictionary* strikeThroughAttributes = @{ NSStrikethroughStyleAttributeName : @1};
    NSDictionary* scriptAttributes = @{ NSFontAttributeName : scriptFont};
    NSDictionary* redTextAttributes =
    @{ NSForegroundColorAttributeName : [UIColor redColor]};
    
    // construct a dictionary of replacements based on regexes
    _replacements = @{
                      @"(\\*\\w+(\\s\\w+)*\\*)\\s" : boldAttributes,
                      @"(_\\w+(\\s\\w+)*_)\\s" : italicAttributes,
                      @"([0-9]+\\.)\\s" : boldAttributes,
                      @"(-\\w+(\\s\\w+)*-)\\s" : strikeThroughAttributes,
                      @"(~\\w+(\\s\\w+)*~)\\s" : scriptAttributes,
                      @"\\s([A-Z]{2,})\\s" : redTextAttributes};
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    //NSLog(@"replaceCharactersInRange:%@ withString:%@", NSStringFromRange(range), str);
    
    [self beginEditing];
    [_backingStore replaceCharactersInRange:range withString:str];
    [self  edited:NSTextStorageEditedCharacters | NSTextStorageEditedAttributes
            range:range
   changeInLength:str.length - range.length];
    [self endEditing];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
{
    //NSLog(@"setAttributes:%@ range:%@", attrs, NSStringFromRange(range));
    
    [self beginEditing];
    [_backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}
@end
