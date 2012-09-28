//
//  PublicGoodsViewController.m
//  EconApps
//
//  Created by Thomas Langford on 9/5/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "PublicGoodsViewController.h"
#import "PublicGoodsView.h"

@interface PublicGoodsViewController ()

@end

@implementation PublicGoodsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = [self.view initWithFrame:self.view.frame];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
@end
