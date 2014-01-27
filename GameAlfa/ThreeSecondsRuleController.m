//
//  FirstViewController.m
//  GameAlfa
//
//  Created by lion carp on 6/14/13.
//  Copyright (c) 2013 Alvan. All rights reserved.
//

#import "ThreeSecondsRuleController.h"
#import "CircularButton.h"
#import "GameAlfaService.h"
#import <SSToolkit/SSPieProgressView.h>


@interface ThreeSecondsRuleController ()
{
    //SyntaxHighlightTextStorage* _textStorage;
    UIWebView* _webView;
    SSPieProgressView *_progressPieView;
    NSTimer *_pieTimer;
}

@end

@implementation ThreeSecondsRuleController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
    }
    return self;
}

- (void)createTextView:(NSString *)description
{
   CGRect newTextViewRect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + self.navigationController.navigationBar.bounds.size.height+20.0f, self.view.bounds.size.width, self.view.bounds.size.height-220);
    

    _webView = [[UIWebView alloc] initWithFrame:newTextViewRect];
    [_webView setBackgroundColor:[UIColor clearColor]];
    NSString *plainContent = description;
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"Body" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    //[_textView loadHTMLString:htmlString baseURL:nil];
    NSString *htmlContentString = [NSString stringWithFormat:
                                   htmlString, plainContent];
    [_webView loadHTMLString:htmlContentString baseURL:nil];
    
    [self.view addSubview:_webView];
}

- (void)createTimer {
    
    // create timer on run loop
    [self killTimer];
    _circularBtnTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
    _pieTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(incrementProgress:) userInfo:nil repeats:YES];
}

- (void)timerTicked:(NSTimer*)timer {

    if (counter == 0) {
        [_goBtn setTitle:@"Go!" forState:UIControlStateNormal];
        NSLog(@"Finished %f", _progressPieView.progress);
        [self killTimer];
        return;
    }
    [_goBtn setTitle:[NSString stringWithFormat:@"%i", counter] forState:UIControlStateNormal];
    counter--;
    
}

- (void)incrementProgress:(NSTimer *)timer {
    NSLog(@"Tick nro %f", _progressPieView.progress);
	_progressPieView.progress = _progressPieView.progress + 0.012;
	if (_progressPieView.progress == 1.0f) {
		_progressPieView.progress = 0.0;
        
        [timer invalidate];
	}
}

-(void)killTimer{
    if (_circularBtnTimer)
    {
        [_circularBtnTimer invalidate];
        _circularBtnTimer = nil;
    }
}

- (void)actionStop:(id)sender {
    [_circularBtnTimer invalidate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"3' Rule";
        Enlatado *enlatado1 = [Enlatado noteWithText:@"someTitle 1" detail:@"Shopping List\r\r1. Cheese\r2. SOME 'Biscuits'\r3. Sausages\r4. IMPORTANT Cash for going out!\r5. -potatoes-\r6. A copy -of iOS6- by ~tutorials~\r7. A new iPhone\r8. A present for mum" resume: @"string"];
    
    [self createTextView:enlatado1.description];
    
    CGRect frame = self.view.bounds;
    _goBtn = [[CircularButton alloc] initWithFrame:CGRectMake((frame.size.width-100.0f)/2, frame.size.height-150.0f, 100.0f, 100.0f)];
    
    [_goBtn setTitle:@"Go!" forState:UIControlStateNormal];
    [_goBtn setTitle:@"Good Luck!" forState:UIControlStateSelected];
    [_goBtn drawCircleButton:[UIColor blackColor]];
    [_goBtn addTarget:self action:@selector(goBtnClick:) forControlEvents:
     (UIControlEvents)UIControlEventTouchDown];
    [_goBtn setBackgroundColor:[UIColor clearColor]];
    _progressPieView = [[SSPieProgressView alloc] initWithFrame:CGRectMake((frame.size.width-100.0f)/2, frame.size.height-150.0f, 100.0f, 100.0f)];
	[self.view addSubview:_progressPieView];
    [self.view addSubview:_goBtn];
}

-(void) goBtnClick:(id)sender{
    [[GameAlfaService sharedInstance] retrieveEnlatado:^(Enlatado *enlatado) {
        counter = 3;
        [self createTimer];
        NSString *desc =enlatado.description;
        NSLog(@"desde servicio %@", desc);
        [_webView removeFromSuperview];
        [_webView release];
        NSString *descriptionText = [NSString stringWithUTF8String:desc.UTF8String];
        [self createTextView:descriptionText];
        
    }];
    NSLog(@"Button Pressed");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) viewDidLayoutSubviews
{
    CGRect newTextViewRect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + self.navigationController.navigationBar.bounds.size.height+20.0f, self.view.bounds.size.width, self.view.bounds.size.height-220);
    _webView.frame = newTextViewRect;//self.view.bounds;
}

- (void)dealloc {
    [_pieTimer release];
    [_circularBtnTimer release];
    [_goBtn release];
    [_webView release];
    [_progressPieView release];
    [_enlatadoLabel release];
    [_timerLabel release];
    [super dealloc];
}
@end
