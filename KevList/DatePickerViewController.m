//
//  DatePickerViewController.m
//  KevList
//
//  Created by E. Kevin Hall on 11/20/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController {
    UILabel *dateLabel;
}

# pragma mark - Actions
- (IBAction)done {
    [self.delegate datePicker:self didPickDate:self.date];
}

- (IBAction)cancel {
    [self.delegate datePickerDidCancel:self];
}

- (IBAction)dueDateChanged {
    self.date = [self.datePicker date];
}

- (void)updateDateLabel {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    dateLabel.text = [formatter stringFromDate:self.date];
}

# pragma mark - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 77;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateCell"];
    dateLabel =  (UILabel *)[cell viewWithTag:1000];
    [self updateDateLabel];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

# pragma mark - Scaffold
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.datePicker setDate:self.date animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
