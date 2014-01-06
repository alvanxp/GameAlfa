//
//  EnlatadoDetailViewController.m
//  GameAlfa
//
//  Created by lion carp on 1/5/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import "EnlatadoDetailViewController.h"

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
    
    self.titleLabel.text = enlatado.title;
    self.detailLabel.text = enlatado.Description;
	// Do any additional setup after loading the view.
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
