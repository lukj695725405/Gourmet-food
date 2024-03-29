//
//  BFUserModel.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/13.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFUserModel.h"

@implementation BFUserModel
    //解档
- (id)initWithCoder:(NSCoder *)decoder
    {
        if (self = [super init]) {
            unsigned int count = 0;
            //获取类中所有成员变量名
            Ivar *ivar = class_copyIvarList([BFUserModel class], &count);
            for (int i = 0; i<count; i++) {
                Ivar iva = ivar[i];
                const char *name = ivar_getName(iva);
                NSString *strName = [NSString stringWithUTF8String:name];
                //进行解档取值
                id value = [decoder decodeObjectForKey:strName];
                //利用KVC对属性赋值
                [self setValue:value forKey:strName];
            }
            free(ivar);
        }
        return self;
    }
    //归档
- (void)encodeWithCoder:(NSCoder *)encoder
    {
        unsigned int count;
        Ivar *ivar = class_copyIvarList([BFUserModel class], &count);
        for (int i=0; i<count; i++) {
            Ivar iv = ivar[i];
            const char *name = ivar_getName(iv);
            NSString *strName = [NSString stringWithUTF8String:name];
            //利用KVC取值
            id value = [self valueForKey:strName];
            [encoder encodeObject:value forKey:strName];
        }
        free(ivar);
    }
@end
