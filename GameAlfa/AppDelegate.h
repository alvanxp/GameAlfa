//
//  AppDelegate.h
//  GameAlfa
//
//  Created by lion carp on 6/14/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
@property (strong, nonatomic) MSClient *client;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
