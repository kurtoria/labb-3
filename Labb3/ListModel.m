//
//  ListModel.m
//  Labb3
//
//  Created by Victoria Grönqvist on 2018-02-01.
//  Copyright © 2018 Victoria Grönqvist. All rights reserved.
//

#import "ListModel.h"

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
        if (self.importantItems == nil) {
            self.importantItems = @[].mutableCopy;
        }
    }
    return self;
}

//Move from one array to another
- (void) moveFrom:(NSMutableArray*)fromArray to:(NSMutableArray*)toArray withItem:(NSMutableArray*)item {
    [self addToArray:toArray withItem:item];
    [self deleteFromArray:fromArray withItem:item];
}

//Delete from array with item
- (void) deleteFromArray:(NSMutableArray*)array withItem:(NSMutableArray*)item {
    [array removeObject:item];
    [self saveArrays];
}

//Add to array with item
- (void) addToArray:(NSMutableArray*)array withItem:(NSMutableArray*)item {
    [array addObject:item];
    [self saveArrays];
}

//Delete from array at row index
- (void) deleteFromArray:(NSMutableArray *)array atRow:(long)row {
    [array removeObjectAtIndex:row];
    [self saveArrays];
}

//Save array
- (void) saveArrays {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.todoItems forKey:@"Todo"];
    [userDefaults setObject:self.doneItems forKey:@"Done"];
    [userDefaults setObject:self.importantItems forKey:@"Important"];
    [userDefaults synchronize];
    NSLog(@"Saved todo: %@, Saved done: %@, Saved important: %@", self.todoItems, self.doneItems, self.importantItems);
}

//Get array
- (void)getArray {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.todoItems = [[userDefaults objectForKey:@"Todo"] mutableCopy];
    self.doneItems = [[userDefaults objectForKey:@"Done"] mutableCopy];
    self.importantItems = [[userDefaults objectForKey:@"Important"] mutableCopy];
}
 

@end
