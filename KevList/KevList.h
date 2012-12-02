//
//  KevList.h
//  KevList
//
//  Created by E. Kevin Hall on 11/18/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KevList : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *iconName;

- (int)countUncheckedItems;

@end
