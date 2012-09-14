//
//  LoginView.h
//  EconApps
//
//  Created by Kevin Sanders on 9/4/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Connection.h"

@interface LoginView : UIView {

    UIButton *loginButton;
    UITextField *usernameField;
    UITextField *passwordField;
    
    NSString *username;
    NSString *password;
    NSString *firstName;
    NSString *lastName;
}

@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;

@property (nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic) IBOutlet UITextField *usernameField;
@property (nonatomic) IBOutlet UITextField *passwordField;



-(IBAction)loginButtonPressed:(id)sender;
-(void)validateLogin:(NSData*)data;


@end
