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
- (void)moveObjectToAnotherMutableArray:(NSMutableArray*)from toMutableArray:(NSMutableArray*) to {
    id path;
    id object;
    object = [from objectAtIndex:path];
    [from removeObject:path];
    [to addObject:object];
}
 */

- (BOOL)moveFromArray:(NSMutableArray *)fromArray toArray:(NSMutableArray *)toArray {
    if ([fromArray containsObject:self]) {
        [fromArray removeObject:self];
        [toArray addObject:self];
        
        return YES;
    } else {
        return NO;
    }
}

@end
