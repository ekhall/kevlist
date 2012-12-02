//
//  KevListViewController.h
//  KevList
//
//  Created by E. Kevin Hall on 10/28/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class KevList;

@interface KevListViewController : UITableViewController <ItemDetailViewControllerDelegate>
@property (nonatomic, strong) KevList *kevlist;

@end
