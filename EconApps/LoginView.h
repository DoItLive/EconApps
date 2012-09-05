//
//  LoginView.h
//  EconApps
//
//  Created by Kevin Sanders on 9/4/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView {

UIButton *loginButton;

}





@property (nonatomic) IBOutlet UIButton *loginButton;


-(IBAction)loginButtonPressed:(id)sender;

@end
