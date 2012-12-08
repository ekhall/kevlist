//
//  UserConfigViewController.h
//  KevList
//
//  Created by E. Kevin Hall on 12/8/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserConfigViewController;
@class AppUser;

@protocol UserConfigViewControllerDelegate <NSObject>
- (void) userConfigViewControllerDidCancel:(UserConfigViewController *) controller;
- (void) userConfigViewController:(UserConfigViewController *) controller didFinishAddingUser:(AppUser *)appUser;
- (void) userConfigViewController:(UserConfigViewController *) controller didFinishEditingUser:(AppUser *)appUser;
@end

@interface UserConfigViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <UserConfigViewControllerDelegate> delegate;

- (IBAction)cancel;
- (IBAction)save;

@end
