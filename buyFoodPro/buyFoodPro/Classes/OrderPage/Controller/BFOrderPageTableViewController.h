//
//  BFOrderPageTableViewController.h
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BFOrderPageTableViewController : BFBaseViewController
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)NSInteger index;
@end

NS_ASSUME_NONNULL_END
