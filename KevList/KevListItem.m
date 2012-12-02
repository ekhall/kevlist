//
//  KevListItem.m
//  KevList
//
//  Created by E. Kevin Hall on 10/28/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "KevListItem.h"
#import "DataModel.h"

@implementation KevListItem

- (id)init {
    if (self = [super init])
        self.itemId = [DataModel nextKevlistItemId];
    return self;
}

- (void)toggleChecked {
    self.checked = !self.checked;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
        self.text           = [aDecoder decodeObjectForKey:@"Text"];
        self.checked        = [aDecoder decodeBoolForKey:@"Checked"];
        self.shouldRemind   = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId         = [aDecoder decodeIntForKey:@"ItemId"];
        self.dueDate        = [aDecoder decodeObjectForKey:@"DueDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInt:self.itemId forKey:@"ItemId"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
}

@end
