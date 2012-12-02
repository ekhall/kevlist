//
//  KevListViewController.m
//  KevList
//
//  Created by E. Kevin Hall on 10/28/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "KevListViewController.h"
#import "KevListItem.h"
#import "KevList.h"

@interface KevListViewController ()

@end

@implementation KevListViewController

# pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Again, using two exits/segues to get to the Add and Edit items
    // 1. The first transition is the add item.
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        controller.delegate     = self;
    }
    
    // 2. The next transition is when an edit is needed
    else if ([segue.identifier isEqualToString:@"EditItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        controller.delegate     = self;
        
        // When there is an item to edit, the controller's so-named pointer is set to the sender.
        controller.itemToEdit   = sender;
    }
}

# pragma mark - Protocol
- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(KevListItem *)item
{
    // Get the index of the next available
    int newRowIndex         = [self.kevlist.items count];
    
    // Add the new item at the new index
    [self.kevlist.items addObject:item];
    
    // Build the indexPath and the indexPaths array to prepare for the addition to the tableView
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths     = [NSArray arrayWithObject:indexPath];
    
    // Insert the kevlist to the table
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(KevListItem *)item
{
    // Get the index of the already-existing kevList
    int index               = [self.kevlist.items indexOfObject:item];
    
    // Get the indexPath of the index
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:index inSection:0];
    
    // Instantiate a cell and point it to the appropriate indexPath
    UITableViewCell *cell   = [self.tableView cellForRowAtIndexPath:indexPath];
    
    // Call the configureText method for the item
    [self configureTextForCell:cell withKevListItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - Tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.kevlist.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The standard prep
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:@"CheckListItem"];
    KevListItem *item       = [self.kevlist.items objectAtIndex:indexPath.row];
    
    // Config the text for this cell from the KevList item
    [self configureTextForCell:cell withKevListItem:item];
    
    // Config the checkmark for this cell based on the setting in the KevList
    [self configureCheckmarkForCell:cell withKevListItem:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Standard prep
    UITableViewCell *cell   = [tableView cellForRowAtIndexPath:indexPath];
    KevListItem *item       = [self.kevlist.items objectAtIndex:indexPath.row];
    
    // If we select the row, it toggles the checkmark
    [item toggleChecked];
    
    // Then we toggle the check in the model
    [self configureCheckmarkForCell:cell withKevListItem:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    KevListItem *item = [self.kevlist.items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditItem" sender:item];
}

- (void)configureTextForCell:(UITableViewCell *)cell withKevListItem:(KevListItem *)item
{
    UILabel *label  = (UILabel *)[cell viewWithTag:1000];
//    label.text      = item.text;
    label.text = [NSString stringWithFormat:@"(%d) %@", item.itemId, item.text];
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withKevListItem:(KevListItem *)item
{
    UILabel *label  = (UILabel *)[cell viewWithTag:1001];
    label.text      = item.checked ? @"√" : @"";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.kevlist.items removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

# pragma mark - Supporting
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.kevlist.name;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
