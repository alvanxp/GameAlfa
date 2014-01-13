//
//  EnlatadosViewController.h
//  GameAlfa
//
//  Created by lion carp on 1/2/14.
//  Copyright (c) 2014 Alvan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnlatadosViewController : UITableViewController
{
    NSMutableIndexSet *expandedSections;
}

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (retain, readwrite) NSMutableArray *enlatados;
@end
