//
//  CircularButton.m
//  GameAlfa
//
//  Created by lion carp on 1/13/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import "CircularButton.h"
#import <SSToolkit/SSPieProgressView.h>
@interface CircularButton()
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) SSPieProgressView *circleView;
@property (nonatomic, strong) UIColor *color;
@end
@implementation CircularButton

- (void)drawCircleButton:(UIColor *)color
{
	self.circleView = [[SSPieProgressView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [self bounds].size.width,                                                                     [self bounds].size.height)];
    self.color = color;
    
    self.backgroundColor = [UIColor clearColor];
    [self setTitleColor:color forState:UIControlStateNormal];
    
    self.circleLayer = [CAShapeLayer layer];
    
    [self.circleLayer setBounds:CGRectMake(0.0f, 0.0f, [self bounds].size.width,
                                           [self bounds].size.height)];
    [self.circleLayer setPosition:CGPointMake(CGRectGetMidX([self bounds]),CGRectGetMidY([self bounds]))];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    [self.circleLayer setPath:[path CGPath]];
    
    [self.circleLayer setStrokeColor:[color CGColor]];
    
    [self.circleLayer setLineWidth:1.0f];
    [self.circleLayer setFillColor:[[UIColor clearColor] CGColor]];
    //[self insertSubview:self.circleView atIndex:self.subviews.count];
    [self.circleLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    [self setBackgroundColor:[UIColor clearColor]];
    [[self layer] addSublayer:self.circleLayer];
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted)
    {
        self.titleLabel.textColor = [UIColor grayColor];
        [self.circleLayer setFillColor:self.color.CGColor];
    }
    else
    {
        [self.circleLayer setFillColor:[UIColor clearColor].CGColor];
        self.titleLabel.textColor = self.color;
    }
}/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
