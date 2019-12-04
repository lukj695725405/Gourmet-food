//
//  TabBarConst.h
//  WebViewTest
//
//  Created by 刘转 on 2019/3/4.
//  Copyright © 2019年 刘转. All rights reserved.
//

#ifndef TabBarConst_h
#define TabBarConst_h

/**
 tabbar高度
 */
#define  lz_tabbarHeight         ((lz_iPhoneX || lz_iPhoneXr || lz_iPhoneXs || lz_iPhoneXsMax) ? (49.f + 34.f) : 49.f)
// 判断是否是ipad
#define lz_isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhoneX
#define lz_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !lz_isPad : NO)
// 判断iPHoneXr
#define lz_iPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !lz_isPad : NO)
// 判断iPhoneXs
#define lz_iPhoneXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !lz_isPad : NO)
// 判断iPhoneXs Max
#define lz_iPhoneXsMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !lz_isPad : NO)
/**
 底部安全间距
 */
#define lz_safeBottomMargin  ((lz_iPhoneX || lz_iPhoneXr || lz_iPhoneXs || lz_iPhoneXsMax) ? 34.f : 0.f)

#endif /* TabBarConst_h */
