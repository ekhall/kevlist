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

- (void)scheduleNotification {
    if ((self.shouldRemind) && [self.dueDate compare:[NSDate date]] != NSOrderedAscending) {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate      = self.dueDate;
        localNotification.timeZone      = [NSTimeZone defaultTimeZone];
        localNotification.alertBody     = self.text;
        localNotification.soundName     = UILocalNotificationDefaultSoundName;
        localNotification.userInfo      = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:self.itemId] forKey:@"ItemID"];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        NSLog(@"Scheduled notification %@ for %d", localNotification, self.itemId);
    }
}

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
