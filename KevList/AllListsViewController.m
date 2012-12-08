//
//  AllListsViewController.m
//  KevList
//
//  Created by E. Kevin Hall on 11/11/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "AllListsViewController.h"
#import "KevListViewController.h"
#import "KevList.h"
#import "KevListItem.h"

@implementation AllListsViewController {
    PFUser *currentUser;
}

# pragma mark - Coder
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        self.dataModel = [[DataModel alloc] init];
    }
    return self;
}

# pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Here are two segues/exits to other VCs.
    
    // 1. If we are told to prepare for a ShowKevLists (e.g. the Kev Lists)
    if ([segue.identifier isEqualToString:@"ShowKevList"]) {
        
        // Instantaite a Kev List VC and set it to the segue's destination VC.
        KevListViewController *controller   = segue.destinationViewController;
        
        // The controller's kevlist pointer in this case is the sender
        controller.kevlist                  = sender;
        
    // 2. Alternatively, we click the add button and segue to that VC
    } else if ([segue.identifier isEqualToString:@"AddKevList"]) {
        
        // Instantiate the nav controller for Adding the Kev List
        UINavigationController *navigationController = segue.destinationViewController;
        
        // Instantiate the List Detail VC and point it to the nav controller's Top VC.
        ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
        
        // The All Lists VC is the delgate
        controller.delegate                 = self;
        
        // This is just going to be nil, as we're adding. 
        controller.kevListToEdit            = nil;
        
    } else if ([segue.identifier isEqualToString:@"UserConfig"]) {
        UINavigationController *navigationController  = segue.destinationViewController;
        UserConfigViewController *controller          = (UserConfigViewController *)navigationController.topViewController;
        controller.delegate                           = self;
    }
}

# pragma mark - Delegate
- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingKevlist:(KevList *)kevlist
{
    // Take the passed-in kevlist and add it to the datamodel
    [self.dataModel.lists addObject:kevlist];
    // Sort appropriately
    [self.dataModel sortKevlists];
    // Reload data
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingKevlist:(KevList *)kevlist
{
    // kevlist is already within the model, so no adding, just sorting.
    [self.dataModel sortKevlists];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userConfigViewControllerDidCancel:(ListDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userConfigViewController:(UserConfigViewController *)controller didFinishLoggingIn:(PFUser *)user {
    currentUser = user;
    NSLog(@"Back in AllLists with user (%@)", [currentUser objectForKey:@"username"]);
    self.navigationController.title = [currentUser objectForKey:@"username"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - TableView methods
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    // When we tap the acccessory button in the list, we segue to the navcontroller
    //   for the add/edit lists.
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListAddEditNavController"];
    
    // The top view controller of the nav controller in this case is the
    //   List Detail View Controller.
    // From the looks of it the code, the nav controller instantiates the
    //   List Detail VC and this only creates the pointer to it from the
    //   top VC pointer within the nav controller.
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    
    // Create local pointer to the kevlist within the datamodel
    KevList *kevlist = [self.dataModel.lists objectAtIndex:indexPath.row];
    
    // The
    controller.kevListToEdit = kevlist;
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Looks like the only thing we use this method for is deletion
    // Remove the indexPath from the model first.
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    // Then remove the appropriate cell from the tableView. 
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 3. Here is another exit/segue: When we select a full-cell we...
    // Call datamodel method to set the index of the selected list...
    [self.dataModel setIndexOfSelectedKevList:indexPath.row];
    
    // Create the local kevlist instance and point it to the appropriate kevlist
    //   in the model.
    KevList *kevlist = [self.dataModel.lists objectAtIndex:indexPath.row];
    
    // Take this pointer and pass it to the KevList VC ("Show Check List")
    [self performSegueWithIdentifier:@"ShowKevList" sender:kevlist];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Setup Cell Dequeue
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Create local kevlist pointer to respective kevlist in datamodel
    KevList *kevlist            = [self.dataModel.lists objectAtIndex:indexPath.row];
    
    // Transfer the data from the objec into the cell
    cell.textLabel.text         = kevlist.name;
    [cell.textLabel setFont:[UIFont fontWithName:@"Avenir" size:18]];
    cell.accessoryType          = UITableViewCellAccessoryDetailDisclosureButton;
    int count = [kevlist countUncheckedItems];
    if ([kevlist.items count] == 0)
        cell.detailTextLabel.text = @"(Empty)";
    else if (count == 0)
        cell.detailTextLabel.text = @"Completed";
    else
        cell.detailTextLabel.text   = [NSString stringWithFormat:@"%d remaining", [kevlist countUncheckedItems]];
    cell.imageView.image = [UIImage imageNamed:kevlist.iconName];
    return cell;
}

# pragma mark - Navigation
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        [self.dataModel setIndexOfSelectedKevList:-1];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Set the navcontroller's delegate to self
    self.navigationController.delegate = self;
    
    // Find the index of the kevlist from the datamodel
    int index = [self.dataModel indexOfSelectedKevList];
    
    // If the index is within the known range of the known lists,
    //   perform the ShowKevList Segue
    if (index >= 0 && index < [self.dataModel.lists count]) {
        KevList *kevlist = [self.dataModel.lists objectAtIndex:index];
        [self performSegueWithIdentifier:@"ShowKevList" sender:kevlist];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Everytime the view reappears, reload the tables to update the textfields
    [self.tableView reloadData];
}

@end