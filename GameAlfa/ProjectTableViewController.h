//
//  ProjectTableViewController.h
//  GameAlfa
//
//  Created by lion carp on 7/20/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectTableViewController : UITableViewController
{
    NSMutableArray *projects;
}

@property (nonatomic, strong) NSArray *carImages;
@property (nonatomic, strong) NSArray *carMakes;
@property (nonatomic, strong) NSArray *carModels;
@property (assign, readwrite) NSMutableArray *projects;
@end
