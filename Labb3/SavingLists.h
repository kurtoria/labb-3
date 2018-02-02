//
//  SavingLists.h
//  Labb3
//
//  Created by Victoria Grönqvist on 2018-02-01.
//  Copyright © 2018 Victoria Grönqvist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SavingLists : NSObject
-(void)saveArrayWithDict:(NSMutableArray*)array andName:(NSString*)name;
-(NSMutableArray*)getArrayWithDict:(NSString*)name;
- (void) saveArray:(NSMutableArray*)array andName:(NSString*)name;
- (NSMutableArray*)getArray:(NSString*)name;


@end
