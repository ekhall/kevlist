//
//  itemDetailViewController.h
//  KevList
//
//  Created by E. Kevin Hall on 10/28/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"

@class ItemDetailViewController;
@class KevListItem;

@protocol ItemDetailViewControllerDelegate <NSObject>
- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;
- (void)itemDetailViewController:(ItemDetailViewController *)controller
          didFinishAddingItem:(KevListItem *)item;
- (void)itemDetailViewController:(ItemDetailViewController *)controller
          didFinishEditingItem:(KevListItem *)item;
@end

@interface ItemDetailViewController : UITableViewController <UITextFieldDelegate, DatePickerViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) id <ItemDetailViewControllerDelegate> delegate;
@property (strong, nonatomic) KevListItem *itemToEdit;
@property (strong, nonatomic) IBOutlet UISwitch *switchControl;
@property (strong, nonatomic) IBOutlet UILabel *dueDateLabel;

- (IBAction)cancel;
- (IBAction)done;

@end
