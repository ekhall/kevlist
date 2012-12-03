//
//  KevListItem.h
//  KevList
//
//  Created by E. Kevin Hall on 10/28/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KevListItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, assign) BOOL shouldRemind;
@property (nonatomic, assign) int itemId;
@property (nonatomic, copy) NSDate *dueDate;

- (void)toggleChecked;
- (void)scheduleNotification;

@end
