//
//  FirstViewController.h
//  GameAlfa
//
//  Created by lion carp on 6/14/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//
#import "CircularButton.h"
#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

@interface ThreeSecondsRuleController : UIViewController<UITextViewDelegate>
{
    NSTimer *_circularBtnTimer;
    int counter;
    CircularButton *_goBtn;
}
@property (retain, nonatomic) IBOutlet UITextView *enlatadoLabel;
@property (retain, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;

@end
