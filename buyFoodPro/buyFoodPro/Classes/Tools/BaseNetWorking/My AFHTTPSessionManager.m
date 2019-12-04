//
//  My AFHTTPSessionManager.m
//  ent
//  封装AFNetWorking
//  Created by Alan on 2018/7/27.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "My AFHTTPSessionManager.h"

@implementation MyAFHTTPSessionManager

+(instancetype)sharedInstance{
    static MyAFHTTPSessionManager *afh = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        afh = [[self alloc]init];
        afh.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return afh;
}

//+(id)allocWithZone:(struct _NSZone *)zone{
//    return [My_AFHTTPSessionManager sharedInstance];
//}
//
//-(id)copyWithZone:(NSZone *)zone{
//    return [My_AFHTTPSessionManager sharedInstance];
//}
//
//-(id)mutableCopyWithZone:(NSZone *)zone{
//    return [My_AFHTTPSessionManager sharedInstance];
//}
@end
