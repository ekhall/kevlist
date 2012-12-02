//
//  KevList.m
//  KevList
//
//  Created by E. Kevin Hall on 11/18/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "KevList.h"
#import "KevListItem.h"

@implementation KevList

- (int)countUncheckedItems
{
    int count = 0;
    for (KevListItem *item in self.items) {
        if (!item.checked) count += 1;
    }
    return count;
}

- (NSComparisonResult)compare:(KevList *)otherKevlist
{
    return [self.name localizedStandardCompare:otherKevlist.name];
}

# pragma mark - Scaffold

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.name       = [aDecoder decodeObjectForKey:@"Name"];
        self.items      = [aDecoder decodeObjectForKey:@"Items"];
        self.iconName   = [aDecoder decodeObjectForKey:@"IconName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
    [aCoder encodeObject:self.iconName forKey:@"IconName"];
}

- (id)init {
    if ((self = [super init])) {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
        self.iconName = @"No Icon";
    }
    return self;
}

@end
