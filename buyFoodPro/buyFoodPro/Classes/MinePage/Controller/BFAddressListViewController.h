//
//  BFAddressListViewController.h
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFAddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BFAddressListViewController : BFBaseViewController
@property (nonatomic, copy) void(^peasantModelBlock)(BFAddressModel *model);
@end

NS_ASSUME_NONNULL_END
