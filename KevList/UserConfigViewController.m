//
//  UserConfigViewController.m
//  KevList
//
//  Created by E. Kevin Hall on 12/8/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#ifdef __IPHONE_6_0
# define ALIGN_CENTER NSTextAlignmentCenter
#else
# define ALIGN_CENTER UITextAlignmentCenter
#endif

#import "UserConfigViewController.h"

@implementation UserConfigViewController {
}


- (IBAction)cancel {
    [self.delegate userConfigViewControllerDidCancel:self];
}


- (IBAction)login {
    
    if ([PFUser currentUser] == nil) {
        [PFUser logInWithUsernameInBackground:self.userTextField.text
                                     password:self.pwTextField.text
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                [self.delegate userConfigViewController:self
                                                                     didFinishLoggingIn:user];
                                            } else {
                                                self.userTextField.text = nil;
                                                self.pwTextField.text = nil;
                                                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                message:errorString
                                                                                               delegate:nil
                                                                                      cancelButtonTitle:@"Ok"
                                                                                      otherButtonTitles:nil, nil];
                                                [alert show];
                                            }
                                        }];
    } else {
        [PFUser logOut];
        [self.delegate userConfigViewControllerDidCancel:self];
    }
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row == 2) && ![PFUser currentUser]) {
        NSLog(@"tapped 2");
        return indexPath;
    }
    else
        return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    if ([PFUser currentUser]) {
        self.userTextField.text = [[PFUser currentUser] objectForKey:@"username"];
        self.loginButton.title = @"Logout";
        self.userTextLabel.text = [NSString stringWithFormat:@"Welcome back %@!",
                          [[PFUser currentUser] objectForKey:@"username"]];
        self.userTextLabel.textAlignment = ALIGN_CENTER;
        [self.userCell setAccessoryType:UITableViewCellAccessoryNone];
    }
}

@end
