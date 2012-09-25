//
//  ViewController.m
//  EconApps
//
//  Created by Christian Weigandt on 9/4/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "LoginViewController.h"
#import "WaitingViewController.h"
#import "LoginView.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Add to notification center that way LoginView can call the function switchToWaitingView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToWaitingView) name:@"switchToWaitingView" object:nil];
    
    UIImage *img = [UIImage imageNamed:@"branded_background3_edited.png"];
    UIImage* bg = [[UIImage alloc] initWithCGImage:img.CGImage scale:1.0 orientation:img.imageOrientation];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:bg]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(void)switchToWaitingView
{
    [self performSegueWithIdentifier:@"loginViewToWaitingView" sender:self];
}

//Pass the first and last name string to the waiting view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"loginViewToWaitingView"]) {
        WaitingViewController *waitingView = [segue destinationViewController];
        waitingView.usernameLabelText = [NSString stringWithFormat:@"%@ %@",[(LoginView*)self.view firstName],[(LoginView*)self.view lastName]];
    }
}

@end
