//
//  itemDetailViewController.m
//  KevList
//
//  Created by E. Kevin Hall on 10/28/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "KevListItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController {
    NSDate *dueDate;
}

# pragma mark - Delegate Actions
- (void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date {
    dueDate = date;
    [self updateDueDateLabel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)datePickerDidCancel:(DatePickerViewController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - Actions
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PickDate"]) {
        DatePickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        controller.date = dueDate;
    }
}

- (IBAction)cancel {
    [self.delegate itemDetailViewControllerDidCancel:self];
}

- (IBAction)done {
    
    // If we are creating a new item (item to edit is nil)...
    if (self.itemToEdit == nil) {
        KevListItem *item = [[KevListItem alloc] init];
        item.text = self.textField.text;
        item.checked = NO;
        item.shouldRemind = self.switchControl.on;
        item.dueDate = dueDate;
        [item.userNames addObject:[[PFUser currentUser] objectForKey:@"username"]];
        [item scheduleNotification];
        
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
        
    // Else if we are editting an item...
    } else {
        self.itemToEdit.text = self.textField.text;
        self.itemToEdit.shouldRemind = self.switchControl.on;
        self.itemToEdit.dueDate = dueDate; 
        [self.itemToEdit.userNames addObject:[[PFUser currentUser] objectForKey:@"username"]];
        [self.itemToEdit scheduleNotification];
        
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
}

# pragma mark - Table Methods
// This next method is invoked every time the user changes text, whether by tapping on the
// keyboard or cutting and pasting.

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
        return indexPath;
    else
        return nil;
}

# pragma mark - Scaffold
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)updateDueDateLabel {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.dueDateLabel.text = [formatter stringFromDate:dueDate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.itemToEdit != nil) {
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
        self.switchControl.on = self.itemToEdit.shouldRemind;
        dueDate = self.itemToEdit.dueDate;
    } else {
        self.switchControl.on = NO;
        dueDate = [NSDate date];
    }
    [self updateDueDateLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
