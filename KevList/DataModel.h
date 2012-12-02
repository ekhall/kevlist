//
//  DataModel.h
//  KevList
//
//  Created by E. Kevin Hall on 11/18/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;

+ (int)nextKevlistItemId;

- (void)saveKevLists;
- (int)indexOfSelectedKevList;
- (void)setIndexOfSelectedKevList:(int)index;
- (void)sortKevlists;

@end
