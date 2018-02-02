//
//  alterMutableArray.m
//  Labb3
//
//  Created by Victoria Grönqvist on 2018-02-01.
//  Copyright © 2018 Victoria Grönqvist. All rights reserved.
//

#import "alterMutableArray.h"

@implementation NSMutableArray (alterMutableArray)

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to {
    if (to != from) {
        id obj = [self objectAtIndex:from];
        [self removeObjectAtIndex:from];
        if (to >= [self count]) {
            [self addObject:obj];
        } else {
            [self insertObject:obj atIndex:to];
        }
    }
}

/*
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
 */

@end
