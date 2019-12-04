//
//  BFAccountManager.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/13.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFAccountManager.h"

@implementation BFAccountManager
+ (void)saveUserDefaultObject:(id)object key:(NSString *)key {
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}


+ (id)getUserDefaultObject:(NSString *)key {
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    id tempObject = [defaults objectForKey:key];
    return tempObject;
}


+ (void)removeObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}
@end
