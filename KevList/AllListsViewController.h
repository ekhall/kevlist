//
//  AllListsViewController.h
//  KevList
//
//  Created by E. Kevin Hall on 11/11/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
#import "DataModel.h"

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate,
UINavigationControllerDelegate>

@property (nonatomic, strong) DataModel *dataModel;


@end
