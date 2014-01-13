//
//  EnlatadoDetailViewController.m
//  GameAlfa
//
//  Created by lion carp on 1/5/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import "EnlatadoDetailViewController.h"
#import "GameAlfaService.h"
@interface EnlatadoDetailViewController ()

@end

@implementation EnlatadoDetailViewController
@synthesize enlatado;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = enlatado.title;
    self.titleLabel.text = enlatado.title;
    self.detailLabel.text = enlatado.description;
   // CGRect frame = self.view.frame;
    //frame.size.height = frame.size.height - self.titleLabel.frame.size.height;
    
    [self.detailLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    //self.detailLabel.frame = frame;
    [self.detailLabel sizeToFit];
    //self.detailLabel.used
	// Do any additional setup after loading the view.
    [self contentSizeRectForTextView:self.detailLabel];
}


- (CGRect)contentSizeRectForTextView:(UITextView *)textView
{
    [textView.layoutManager ensureLayoutForTextContainer:textView.textContainer];
    CGRect textBounds = [textView.layoutManager usedRectForTextContainer:textView.textContainer];
    CGFloat width =  (CGFloat)ceil(textBounds.size.width + textView.textContainerInset.left + textView.textContainerInset.right);
    CGFloat height = (CGFloat)ceil(textBounds.size.height + textView.textContainerInset.top + textView.textContainerInset.bottom);
    return CGRectMake(0, 0, width, height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [_titleLabel release];
    [_detailLabel release];
    [super dealloc];
}
@end
