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
    
    NSString *postString = [[NSString alloc] initWithFormat:@"username=%@&password=%@",username,password];
    [[Connection alloc] initWithSelector:@selector(validateLogin:)
                                toTarget:self
                                 withURL:kSERVER_URL
                              withString:postString];
}

-(void)validateLogin:(NSData *)data{
    
    /* Data should be returned from the server in this form:
     1 or 0, followed by parameters specific to the login state, where 1 means a valid login and 0 means an invalid login
     Valid Login: 1,firstName,lastName
     Invalid Login: 0,[1,0] where [1,0] is 0 is for invalid username and 1 is for invalid password
    */
    
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *chunks = [[NSArray alloc] initWithArray:[responseString componentsSeparatedByString: @","]];
    
    NSInteger valid = [[chunks objectAtIndex:0] integerValue]; //Whether valid login or not

    //If valid login then switch to waiting view, else give an alert telling whether invalid username or password
    if (valid) {
        //Switch to waiting view
        [[NSNotificationCenter defaultCenter] postNotificationName:@"switchToWaitingView" object:nil];
        
    } else {
        NSString *alertMessage;
        if ([[chunks objectAtIndex:1] integerValue] == 0) {
            alertMessage = [[NSString alloc] initWithFormat:@"Not a valid username"];
        } else {
            alertMessage = [[NSString alloc] initWithFormat:@"Not a valid password"];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:alertMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSInteger code = [[jsonData objectForKey:@"code"] integerValue];
    
    if (code == kVALID_LOGIN) {
        
    } else if (code == KINVALID_USERNAME || code == KINVALID_PASSWORD) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:[[jsonData objectForKey:@"err_msg"] string] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
