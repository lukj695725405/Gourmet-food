//
//  BFAccountManager.h
//  buyFoodPro
//
//  Created by Lukj on 2019/11/13.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFAccountManager : NSObject
+ (void)saveUserDefaultObject:(id)object key:(NSString *)key;
+ (id)getUserDefaultObject:(NSString *)key;
+ (void)removeObjectWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
