//
//  UserConfigViewController.h
//  KevList
//
//  Created by E. Kevin Hall on 12/8/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class UserConfigViewController;
@class AppUser;

@protocol UserConfigViewControllerDelegate <NSObject>
- (void) userConfigViewControllerDidCancel:(UserConfigViewController *) controller;
- (void) userConfigViewController:(UserConfigViewController *) controller didFinishLoggingIn:(PFUser *)user;
@end

@interface UserConfigViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <UserConfigViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *pwTextField;
@property (strong, nonatomic) IBOutlet UILabel *userTextLabel;
@property (strong, nonatomic) IBOutlet UITableViewCell *userCell;

- (IBAction)cancel;
- (IBAction)login;

@end
