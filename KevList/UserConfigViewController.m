//
//  UserConfigViewController.m
//  KevList
//
//  Created by E. Kevin Hall on 12/8/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "UserConfigViewController.h"

@implementation UserConfigViewController


- (IBAction)cancel {
    [self.delegate userConfigViewControllerDidCancel:self];
}


- (IBAction)save {
    [self.delegate userConfigViewControllerDidCancel:self];
}


@end
