//
//  BFFoodModel.h
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFFoodModel : NSObject
@property (nonatomic ,copy)NSString * goodid;
@property (nonatomic ,copy)NSString * usetype;
@property (nonatomic ,copy)NSString * userid;
@property (nonatomic ,copy)NSString * createtime;
/// 商品名称
@property (nonatomic ,copy)NSString * goodname;
/// 商品图片
@property (nonatomic ,copy)NSString * goodprice;
/// 描述
@property (nonatomic ,copy)NSString * gooddesc;
/// 商品图片
@property (nonatomic ,copy)NSString * goodimage;
/// 商品内容
@property (nonatomic ,copy)NSString * goodcontent;
@property (nonatomic ,copy)NSString * goodstate;
/// 商品类型
@property (nonatomic ,copy)NSString * extend1;
/// 商品库存
@property (nonatomic ,copy)NSString * extend2;
@property (nonatomic ,copy)NSString * extend3;
/// 来自
@property (nonatomic ,copy)NSString * extend4;
@end

NS_ASSUME_NONNULL_END
