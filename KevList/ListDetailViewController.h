//
//  ListDetailViewController.h
//  KevList
//
//  Created by E. Kevin Hall on 11/18/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"

@class ListDetailViewController;
@class KevList;

@protocol ListDetailViewControllerDelegate <NSObject>
- (void) listDetailViewControllerDidCancel:(ListDetailViewController *) controller;
- (void) listDetailViewController:(ListDetailViewController *) controller didFinishAddingKevlist:(KevList *)kevlist;
- (void) listDetailViewController:(ListDetailViewController *) controller didFinishEditingKevlist:(KevList *)kevlist;
@end

@interface ListDetailViewController : UITableViewController <UITextFieldDelegate, IconPickerViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) KevList *kevListToEdit;
@property (nonatomic, strong) IBOutlet UIImageView *iconImageView;

- (IBAction)cancel;
- (IBAction)done;

@end
