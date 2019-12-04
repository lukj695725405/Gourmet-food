//
//  BFOrderPageTableViewCell.h
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@class BFOrderPageTableViewCell;

@protocol BFOrderPageTableViewCellDelegate <NSObject>

- (void)orderPageTableViewCell:(BFOrderPageTableViewCell *)orderPageTableViewCell andCancelModel:(BFOrderModel *)model;

@end

@interface BFOrderPageTableViewCell : UITableViewCell
@property (nonatomic, weak)id <BFOrderPageTableViewCellDelegate>delelgate;
@property (nonatomic, strong)BFOrderModel *model;
@end

NS_ASSUME_NONNULL_END
