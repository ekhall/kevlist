//
//  DataModel.m
//  KevList
//
//  Created by E. Kevin Hall on 11/18/12.
//  Copyright (c) 2012 E. Kevin Hall. All rights reserved.
//

#import "DataModel.h"
#import "KevList.h"

@implementation DataModel

+ (int)nextKevlistItemId {
    NSUserDefaults *userDefaults    = [NSUserDefaults standardUserDefaults];
    int itemId                      = [userDefaults integerForKey:@"KevlistItemId"];
    [userDefaults setInteger:itemId + 1 forKey:@"KevlistItemId"];
    [userDefaults synchronize];
    return itemId;
}

- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return documentDirectory;
}

- (NSString *)dataFilePath {
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}

- (void)saveKevLists
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"KevLists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)loadKevLists
{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.lists = [unarchiver decodeObjectForKey:@"KevLists"];
        [unarchiver finishDecoding];
    } else {
        self.lists = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

- (int)indexOfSelectedKevList {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"KevListIndex"];
}

- (void)setIndexOfSelectedKevList:(int)index
{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"KevListIndex"];
}

- (void) registerDefaults {
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInt:-1], @"KevListIndex",
                                [NSNumber numberWithBool:YES], @"FirstTime",
                                [NSNumber numberWithInt:0], @"KevlistItemId",
                                nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

- (void)sortKevlists
{
    [self.lists sortUsingSelector:@selector(compare:)];
}

- (void)handleFirstTime {
    BOOL firstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTime"];
    if (firstTime) {
        KevList *kevlist = [[KevList alloc] init];
        kevlist.name = @"My First List";
        [self.lists addObject:kevlist];
        [self setIndexOfSelectedKevList:0];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstTime"];
    }
}

- (id)init {
    if ((self = [super init])) {
        [self loadKevLists];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}

@end
