//
//  IconPickerViewController.m
//  KevList
//
//  Created by E. Kevin Hall on 11/19/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "IconPickerViewController.h"

@implementation IconPickerViewController {
    NSArray *icons;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [icons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell"];
    NSString *icon = [icons objectAtIndex:indexPath.row];
    cell.textLabel.text = icon;
    cell.imageView.image = [UIImage imageNamed:icon];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *iconName = [icons objectAtIndex:indexPath.row];
    [self.delegate iconPicker:self didPickIcon:iconName];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    icons = [NSArray arrayWithObjects:
             @"No Icon",
             @"Appointments",
             @"Birthdays",
             @"Chores",
             @"Drinks",
             @"Folder",
             @"Groceries",
             @"Inbox",
             @"Photos",
             @"Trips", nil];
}

@end
