//
//  alterMutableArray.h
//  Labb3
//
//  Created by Victoria Grönqvist on 2018-02-01.
//  Copyright © 2018 Victoria Grönqvist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MoveArray)
- (BOOL)moveFromArray:(NSMutableArray *)fromArray toArray:(NSMutableArray *)toArray;

@end
