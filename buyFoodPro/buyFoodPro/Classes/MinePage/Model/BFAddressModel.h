//
//  BFAddressModel.h
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFAddressModel : NSObject
/*
 {
 "addressid": 40,
 "usetype": 375,
 "userid": 105,
 "createtime": "2019-06-19 14:26:27",
 "address": "浙江省杭州市大关路",
 "city": "杭州",
 "phone": "18911093564",
 "postcode": "",
 "name": "收集",
 "extend1": ""
 */
@property (nonatomic, copy)NSString *addressid;
@property (nonatomic, copy)NSString *usetype;
@property (nonatomic, copy)NSString *userid;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *city;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *postcode;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *createtime;


@end

NS_ASSUME_NONNULL_END
