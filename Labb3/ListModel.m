//
//  ListModel.m
//  Labb3
//
//  Created by Victoria Grönqvist on 2018-02-01.
//  Copyright © 2018 Victoria Grönqvist. All rights reserved.
//

#import "ListModel.h"
#import "SavingLists.h"

@implementation ListModel

- (instancetype) init {
    self = [super init];
    
    if (self) {
        
        [self getArray];
        
        if (self.todoItems == nil) {
            self.todoItems = @[].mutableCopy;
        }
        if (self.doneItems == nil) {
            self.doneItems = @[].mutableCopy;
        }
    }
    return self;
}

//Save array
- (void) saveArrays {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.todoItems forKey:@"Todo"];
    [userDefaults setObject:self.doneItems forKey:@"Done"];
    [userDefaults synchronize];
    NSLog(@"Saved todo: %@, Saved done: %@", self.todoItems, self.doneItems);
}

//Get array
- (void)getArray {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.todoItems = [[userDefaults objectForKey:@"Todo"] mutableCopy];
    self.doneItems = [[userDefaults objectForKey:@"Done"] mutableCopy];
    //[userDefaults objectForKey:@"Todo"];
}



-(NSMutableArray*) addObjectToArray:(NSMutableArray*)array {
    return array;
}

- (void)moveBetweenArray:(NSMutableArray *)todoArray toArray:(NSMutableArray *)doneArray withSection:(long)indexPath {
    if (indexPath == 0) {
        NSMutableArray *item = [todoArray[indexPath] mutableCopy];
        [doneArray addObject:item];
        [todoArray removeObject:item];
    } else {
        NSMutableArray *item = [doneArray[indexPath] mutableCopy];
        [todoArray addObject:item];
        [doneArray removeObject:item];
    }
}
 

@end
