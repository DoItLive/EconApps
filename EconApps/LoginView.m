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

@synthesize loginButton, usernameField, passwordField, firstName, lastName;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(IBAction)loginButtonPressed:(id)sender{
    
    username = [usernameField text];
    password = [passwordField text];
    
    //Ensure there is something in the username and password fields before sending them to the server
    if ([username length] == 0 || [password length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"A username and password must be entered." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    NSString *postString = [[NSString alloc] initWithFormat:@"username=%@&passwd=%@",username,password];

    Connection *conn = [[Connection alloc] initWithFinishSelector:@selector(validateLogin:)
                             withFailSelector:@selector(connectionFailed)
                                      toTarget:self
                                       withURL:kLOGIN_VIEW_URL
                                    withString:postString];
    [conn connect];
}

-(void)validateLogin:(NSData *)data{
    
    /* Data should be returned from the server in a JSON string:
     code: [0..2]
     first: "first name"
     last: "last name"
     err_msg: "error message"
    */
    
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSInteger code = [[jsonData objectForKey:@"code"] integerValue];
    
    if (code == kVALID_LOGIN) {
        firstName = [NSString stringWithString:[jsonData objectForKey:@"first"]];
        lastName = [NSString stringWithString:[jsonData objectForKey:@"last"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"switchToWaitingView" object:nil];
    } else if (code == KINVALID_USERNAME || code == KINVALID_PASSWORD) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:[jsonData objectForKey:@"err_msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)connectionFailed {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not connect to the server" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alert show];
}

@end
