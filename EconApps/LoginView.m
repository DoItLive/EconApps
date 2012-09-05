//
//  LoginView.m
//  EconApps
//
//  Created by Kevin Sanders on 9/4/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "LoginView.h"

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
                                 withURL:@"URL"
                              withString:postString];
    
    
}

-(void)validateLogin:(NSData *)data{
    
    
    
}

@end
