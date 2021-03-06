//
//  WaitingViewController.m
//  EconApps
//
//  Created by Christian Weigandt on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "WaitingViewController.h"
#import "PublicGoodsViewController.h"

@interface WaitingViewController ()

@end

@implementation WaitingViewController

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
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToPublicGoodsView) name:@"switchToPublicGoodsView" object:nil];
    
    UIImage *img = [UIImage imageNamed:@"branded_background3_edited.png"];
    UIImage* bg = [[UIImage alloc] initWithCGImage:img.CGImage scale:1.0 orientation:img.imageOrientation];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:bg]];

}

//Calling initView in viewDidAppear instead of viewDidLoad because otherwise it will try to move on to the next segue before the current
//segue is done.  Also pass in the username label for the waiting view.
- (void)viewDidAppear:(BOOL)animated {
    [(WaitingView*)self.view initView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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

-(void)switchToPublicGoodsView
{
    [self performSegueWithIdentifier:@"waitingViewToPublicGoodsView" sender:self];
}

@end
