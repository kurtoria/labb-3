//
//  SavingLists.m
//  Labb3
//
//  Created by Victoria Grönqvist on 2018-02-01.
//  Copyright © 2018 Victoria Grönqvist. All rights reserved.
//

#import "SavingLists.h"

@implementation SavingLists

//Saving arrays with dict
-(void)saveArrayWithDict:(NSMutableArray*)array andName:(NSString*)name {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:array forKey:name];
    [userDefaults synchronize];
}

//Getting arrays with dict
-(NSMutableArray*)getArrayWithDict:(NSString*)name {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults objectForKey:name];
}

//Save array
- (void) saveArray:(NSMutableArray*)array andName:(NSString*)name {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:array forKey:name];
    [userDefaults synchronize];
}

//Get array
- (NSMutableArray*)getArray:(NSString*)name {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults objectForKey:name];
}

@end
