//
//  EnlatadoDetailViewController.h
//  GameAlfa
//
//  Created by lion carp on 1/5/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enlatado.h"

@interface EnlatadoDetailViewController : UIViewController
//@property (retain, nonatomic) IBOutlet UILabel *detailLabel;
//@property (retain, nonatomic) IBOutlet UITextView *titleLabel;
//@property (retain, nonatomic) IBOutlet UITextView *detailLabel;
@property (retain, nonatomic) IBOutlet UITextView *detailLabel;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
//@property (retain, nonatomic) IBOutlet UITextView *titleLabel;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (nonatomic,retain) Enlatado* enlatado;
@end
