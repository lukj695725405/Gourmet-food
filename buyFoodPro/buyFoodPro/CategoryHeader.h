//
//  CategoryHeader.h
//  NongBaBi
//
//  Created by Alan on 2018/3/22.
//  Copyright © 2018年 NBB. All rights reserved.
//

#ifndef CategoryHeader_h
#define CategoryHeader_h


//#import "UILabel+JLExtension.h"
//#import "UIButton+JLExtension.h"
//#import "UITextField+JLExtension.h"
//#import "UITableView+JLExtension.h"
//#import "UIScrollView+JLExtension.h"
//#import "UIView+JLExtension.h"
//#import "UIView+JLFrame.h"
//#import "UIImage+JLExtension.h"
//
//#import "NSString+JLExtension.h"
//
////#import "UIViewController+HUD.h"
//
//#import "UIViewController+Nav.h"

//----------------------宏文件-------------------

#ifdef DEBUG // 开发阶段
#define JLLog(...)  NSLog(__VA_ARGS__)

#define JSONLOG(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);

#else // 发布阶段
#define JLLog(...)
#define JSONLOG(FORMAT, ...)

#endif

#define MainScreen [UIScreen mainScreen].bounds
#define Screen_W [UIScreen mainScreen].bounds.size.width

//IPHONE X 底部间距
#define SysBottomSpace ([UIScreen mainScreen].bounds.size.height == 812.0 ? 34 : 0)
//安全区域高度
#define Screen_H ([UIScreen mainScreen].bounds.size.height-SysBottomSpace)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define StrongSelf(strongSelf)  __strong __typeof(&*self)strongSelf = self

#define NavHeight ([UIScreen mainScreen].bounds.size.height == 812.0 ? 88 : 64)

//#define NavHeight ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height)
#define TabHeight ([UIScreen mainScreen].bounds.size.height == 812.0 ? 83 : 49)

#endif /* CategoryHeader_h */
