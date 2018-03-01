//
//  ListModel.h
//  Labb3
//
//  Created by Victoria Grönqvist on 2018-02-01.
//  Copyright © 2018 Victoria Grönqvist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject
@property (nonatomic) NSMutableArray *todoItems;
@property (nonatomic) NSMutableArray *doneItems;
@property (nonatomic) NSMutableArray *importantItems;

- (void) deleteFromArray:(NSMutableArray*)array withItem:(NSMutableArray*)item;
- (void) addToArray:(NSMutableArray*)array withItem:(NSMutableArray*)item;
- (void) moveFrom:(NSMutableArray*)fromArray to:(NSMutableArray*)toArray withItem:(NSMutableArray*)item;
- (void) deleteFromArray:(NSMutableArray *)array atRow:(long)row;
- (void) saveArrays;

@end
