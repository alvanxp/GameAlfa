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
    UIWebView* _textView;
    SSPieProgressView *_progressView7;
    NSTimer *_timer;
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
    //Enlatado *enlatado1 = [Enlatado noteWithText:@"someTitle 1" detail:@"Shopping List\r\r1. Cheese\r2. SOME 'Biscuits'\r3. Sausages\r4. IMPORTANT Cash for going out!\r5. -potatoes-\r6. A copy -of iOS6- by ~tutorials~\r7. A new iPhone\r8. A present for mum" resume: @"string"];
    

        CGRect newTextViewRect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + self.navigationController.navigationBar.bounds.size.height+20.0f, self.view.bounds.size.width, self.view.bounds.size.height-220);
    
    // 2. Create the layout manager
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    
    // 3. Create a text container
    CGSize containerSize = CGSizeMake(newTextViewRect.size.width,  CGFLOAT_MAX);
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:containerSize];
    container.widthTracksTextView = YES;
    [layoutManager addTextContainer:container];
    //[_textStorage addLayoutManager:layoutManager];
    
    // 4. Create a UITextView
    _textView = [[UIWebView alloc] initWithFrame:newTextViewRect];
    [_textView setBackgroundColor:[UIColor clearColor]];
    NSString *plainContent = description;
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"Body" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    //[_textView loadHTMLString:htmlString baseURL:nil];
    NSString *htmlContentString = [NSString stringWithFormat:
                                   htmlString, plainContent];
    [_textView loadHTMLString:htmlContentString baseURL:nil];
    
    [self.view addSubview:_textView];
}

- (void)createTimer {
    
    // create timer on run loop
    [self killTimer];
    pollingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(incrementProgress:) userInfo:nil repeats:YES];
}

- (void)timerTicked:(NSTimer*)timer {

    if (counter == 0) {
        [myButton setTitle:@"Go!" forState:UIControlStateNormal];
        NSLog(@"Finished %f", _progressView7.progress);
        [self killTimer];
        return;
    }
    [myButton setTitle:[NSString stringWithFormat:@"%i", counter] forState:UIControlStateNormal];
    counter--;
    
}

- (void)incrementProgress:(NSTimer *)timer {
    NSLog(@"Tick nro %f", _progressView7.progress);
	_progressView7.progress = _progressView7.progress + 0.012;
	if (_progressView7.progress == 1.0f) {
		_progressView7.progress = 0.0;
        
        [timer invalidate];
	}
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
    self.title = @"3' Rule";
        Enlatado *enlatado1 = [Enlatado noteWithText:@"someTitle 1" detail:@"Shopping List\r\r1. Cheese\r2. SOME 'Biscuits'\r3. Sausages\r4. IMPORTANT Cash for going out!\r5. -potatoes-\r6. A copy -of iOS6- by ~tutorials~\r7. A new iPhone\r8. A present for mum" resume: @"string"];
    
    [self createTextView:enlatado1.description];
    
    CGRect frame = self.view.bounds;
    myButton = [[CircularButton alloc] initWithFrame:CGRectMake((frame.size.width-100.0f)/2, frame.size.height-150.0f, 100.0f, 100.0f)];
    
    
    [myButton setTitle:@"Go!" forState:UIControlStateNormal];
    [myButton setTitle:@"Good Luck!" forState:UIControlStateSelected];
    [myButton drawCircleButton:[UIColor blackColor]];
    [myButton addTarget:self action:@selector(myButtonClick:) forControlEvents:
     (UIControlEvents)UIControlEventTouchDown];
    [myButton setBackgroundColor:[UIColor clearColor]];
    _progressView7 = [[SSPieProgressView alloc] initWithFrame:CGRectMake((frame.size.width-100.0f)/2, frame.size.height-150.0f, 100.0f, 100.0f)];
	[self.view addSubview:_progressView7];
    [self.view addSubview:myButton];
	// Do any additional setup after loading the view, typically from a nib.

}

-(void) myButtonClick:(id)sender{
    [[GameAlfaService sharedInstance] retrieveEnlatado:^(Enlatado *enlatado) {
        counter = 3;
        [self createTimer];
        NSString *desc =enlatado.description;
        NSLog(@"desde servicio %@", desc);
        [_textView removeFromSuperview];
        [_textView release];
        NSString *algo = @"Shopping List\r\r1. Cheese\r2. SOME 'Biscuits'\r3. Sausages\r4. IMPORTANT Cash for going out!\r5. -potatoes-\r6. A copy -of iOS6- by ~tutorials~\r7. A new iPhone\r8. A present for mum";
        //NSStringEncodingConversionOptions *encodings= algo.availableStringEncodings;
        NSLog(@"desde constante %@", algo);
       // [algo]
        //[desc dataUsingEncoding:NSUnicodeStringEncoding];
        NSData *data = [desc dataUsingEncoding:NSUTF16StringEncoding];
        NSString *d = [NSString stringWithUTF8String:desc.UTF8String];//[[NSString alloc] initWithData:data encoding:NSUnicodeStringEncoding];
        [self createTextView:d];
        
    }];
    NSLog(@"Button Pressed");
}

- (void)preferredContentSizeChanged:(NSNotification *)n {
   // _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    //[self updateTimeIndicatorFrame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidLayoutSubviews
{
        CGRect newTextViewRect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + self.navigationController.navigationBar.bounds.size.height+20.0f, self.view.bounds.size.width, self.view.bounds.size.height-220);
    _textView.frame = newTextViewRect;//self.view.bounds;
}

- (void)dealloc {
    [_enlatadoLabel release];
    [_timerLabel release];
    [super dealloc];
}
@end
