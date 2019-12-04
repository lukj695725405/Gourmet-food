//
//  BFOrderModel.h
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFFoodModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BFOrderModel : NSObject
@property (nonatomic, copy)NSString *orderid;
@property (nonatomic, copy)NSString *buyuserid;// 用户id
@property (nonatomic, copy)NSString *usetype;
@property (nonatomic, copy)NSString *saleuserid;// 商家id
@property (nonatomic, copy)NSString *goodid;
@property (nonatomic, copy)NSString *userorderid;
@property (nonatomic, copy)NSString *goodcount;
@property (nonatomic, copy)NSString *totalprice;
@property (nonatomic, copy)NSString *orderstate;
@property (nonatomic, copy)NSString *receiveaddress;
@property (nonatomic, copy)NSString *receivename;
@property (nonatomic, copy)NSString *receivephone;
@property (nonatomic, copy)NSString *orderdesc;
@property (nonatomic, copy)NSString *createtime;
@property (nonatomic, copy)NSString *extend1;
@property (nonatomic, copy)NSString *extend2;
@property (nonatomic, strong)BFFoodModel *tyGoods;
@end

NS_ASSUME_NONNULL_END
