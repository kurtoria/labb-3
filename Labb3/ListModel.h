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

@end
