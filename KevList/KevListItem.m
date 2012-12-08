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

// This method checks to see if this item (self) already has a notification and, if so, returns it.
// Otherwise it returns nil.
- (UILocalNotification *)notificationForThisItem {
    
    // Create an array of all notifications handled by this app.
    NSArray *allNotifications  = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    // Fast iteration through the array of all notifications.
    for (UILocalNotification *notification in allNotifications) {
        
        // Find the NSNumber inside the dictionary for the key ItemID.
        NSNumber *number = [notification.userInfo objectForKey:@"ItemID"];
        
        // If non-nil and the integer value is the same as our own itemId, return the notification.
        if (number != nil && [number intValue] == self.itemId)
            return notification;
    }
    return nil;
}

- (void)scheduleNotification {
    // Create pointer to existing notification
    UILocalNotification *existingNotification = [self notificationForThisItem];
    
    // If this is found (non nil), blow it away
    if (existingNotification != nil) {
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
    
    // Next, IF we need to create another notification, set it up.
    if ((self.shouldRemind) && [self.dueDate compare:[NSDate date]] != NSOrderedAscending) {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate      = self.dueDate;
        localNotification.timeZone      = [NSTimeZone defaultTimeZone];
        localNotification.alertBody     = self.text;
        localNotification.soundName     = UILocalNotificationDefaultSoundName;
        localNotification.userInfo      = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:self.itemId] forKey:@"ItemID"];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        // NSLog(@"Scheduled notification %@ for %d", localNotification, self.itemId);
    }
    // NSLog(@"All Notifications: %@", [[UIApplication sharedApplication] scheduledLocalNotifications]);
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

# pragma mark - Dealloc method
- (void) dealloc {
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if (existingNotification != nil) {
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
}

@end
