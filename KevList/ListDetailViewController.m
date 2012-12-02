//
//  ListDetailViewController.m
//  KevList
//
//  Created by E. Kevin Hall on 11/18/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "ListDetailViewController.h"
#import "KevList.h"

@implementation ListDetailViewController {
    NSString *iconName;
}

# pragma mark - Actions
- (IBAction)cancel {
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)done {
    if (self.kevListToEdit == nil) {
        KevList *kevlist = [[KevList alloc] init];
        kevlist.name = self.textField.text;
        kevlist.iconName = iconName;
        [self.delegate listDetailViewController:self didFinishAddingKevlist:kevlist];
    } else {
        self.kevListToEdit.name = self.textField.text;
        self.kevListToEdit.iconName = iconName;
        [self.delegate listDetailViewController:self didFinishEditingKevlist:self.kevListToEdit];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Choose Icon"]) {
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

- (void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)theIconName {
    iconName = theIconName;
    self.iconImageView.image = [UIImage imageNamed:iconName];
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark - Tableview
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
        return indexPath;
    else
        return nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range
                                                                withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

# pragma mark - Scaffold
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder]))
        iconName = @"Folder";
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.kevListToEdit != nil) {
        self.title                  = @"Edit KevList";
        self.textField.text         = self.kevListToEdit.name;
        self.doneBarButton.enabled  = YES;
        iconName                    = self.kevListToEdit.iconName;
    }
    self.iconImageView.image = [UIImage imageNamed:iconName];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

@end
