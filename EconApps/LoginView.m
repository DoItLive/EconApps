//
//  LoginView.m
//  EconApps
//
//  Created by Kevin Sanders on 9/4/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "LoginView.h"
#import "Defs.h"

@implementation LoginView

@synthesize loginButton, usernameField, passwordField;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)loginButtonPressed:(id)sender{
    
    username = [usernameField text];
    password = [passwordField text];
    
    if ([username length] == 0 || [password length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"A username and password must be entered." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    NSString *postString = [[NSString alloc] initWithFormat:@"username=%@&passwd=%@",username,password];
    [[Connection alloc] initWithSelector:@selector(validateLogin:)
                                toTarget:self
                                 withURL:kLOGIN_VIEW_URL
                              withString:postString];
}

-(void)validateLogin:(NSData *)data{
    
    /* Data should be returned from the server in this form:
     1 or 0, followed by parameters specific to the login state, where 1 means a valid login and 0 means an invalid login
     Valid Login: 1,firstName,lastName
     Invalid Login: 0,[1,0] where [1,0] is 0 is for invalid username and 1 is for invalid password
    */
    
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSInteger code = [[jsonData objectForKey:@"code"] integerValue];
    
    if (code == kVALID_LOGIN) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"switchToWaitingView" object:nil];
    } else if (code == KINVALID_USERNAME || code == KINVALID_PASSWORD) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:[jsonData objectForKey:@"err_msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
