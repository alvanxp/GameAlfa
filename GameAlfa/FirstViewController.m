//
//  FirstViewController.m
//  GameAlfa
//
//  Created by lion carp on 6/14/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import "FirstViewController.h"
#import "CircularButton.h"
#import "GameAlfaService.h"

@interface FirstViewController ()


@end

@implementation FirstViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
    }
    return self;
}

- (void)createTimer {
    
    // create timer on run loop
    [self killTimer];
    pollingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
}

- (void)timerTicked:(NSTimer*)timer {
    if (counter == 0) {
        [myButton setTitle:@"Start" forState:UIControlStateNormal];
        [self killTimer];
        return;
    }
    // decrement timer 1 … this is your UI, tick down and redraw
    //[myStopwatch tickDown];
    //[myStopwatch.view setNeedsDisplay];
    [myButton setTitle:[NSString stringWithFormat:@"%i", counter] forState:UIControlStateNormal];
    counter--;
    
    // increment timer 2 … bump time and redraw in UI
    
}

-(void)killTimer{
    if (pollingTimer)
    {
        
        [pollingTimer invalidate];
        pollingTimer = nil;
    }
}

- (void)actionStop:(id)sender {
    [pollingTimer invalidate];
    // stop the timer
    //[myTimer invalidate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    CGRect frame = self.view.bounds;
    myButton = [[CircularButton alloc] initWithFrame:CGRectMake((frame.size.width-100.0f)/2, frame.size.height-150.0f, 100.0f, 100.0f)];
    
    
    [myButton setTitle:@"Start" forState:UIControlStateNormal];
    [myButton setTitle:@"Good Luck!" forState:UIControlStateSelected];
    [myButton drawCircleButton:[UIColor blackColor]];
    [myButton addTarget:self action:@selector(myButtonClick:) forControlEvents:
     (UIControlEvents)UIControlEventTouchDown];
    [self.view addSubview:myButton];
	// Do any additional setup after loading the view, typically from a nib.
    
}

-(void) myButtonClick:(id)sender{
    [[GameAlfaService sharedInstance] retrieveEnlatado:^(Enlatado *enlatado) {
        counter = 3;
        [self createTimer];
        self.enlatadoLabel.text = enlatado.description;
    }];
    NSLog(@"Button Pressed");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_enlatadoLabel release];
    [_timerLabel release];
    [super dealloc];
}
@end
