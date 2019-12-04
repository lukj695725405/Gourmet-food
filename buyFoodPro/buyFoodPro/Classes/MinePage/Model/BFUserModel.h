//
//  BFUserModel.h
//  buyFoodPro
//
//  Created by Lukj on 2019/11/13.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFUserModel : NSObject<NSCoding>
@property (nonatomic, strong)NSString *userid;
@property (nonatomic, strong)NSString *usetype;
@property (nonatomic, strong)NSString *nickname;
@property (nonatomic, strong)NSString *password;
@property (nonatomic, strong)NSString *avatar;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *age;
@property (nonatomic, strong)NSString *sex;
@property (nonatomic, strong)NSString *iden;
@property (nonatomic, strong)NSString *createtime;
@property (nonatomic, strong)NSString *phonenum;
@property (nonatomic, strong)NSString *extend1;
@end

NS_ASSUME_NONNULL_END
