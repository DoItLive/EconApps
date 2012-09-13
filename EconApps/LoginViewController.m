//
//  ViewController.m
//  EconApps
//
//  Created by Christian Weigandt on 9/4/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Add to notification center that way LoginView can call the function switchToWaitingView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToWaitingView) name:@"switchToWaitingView" object:nil];
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

-(void)switchToWaitingView
{
    [self performSegueWithIdentifier:@"loginViewToWaitingView" sender:self];
}

@end
