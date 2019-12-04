//
//  BFOrderPageTableViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFOrderPageTableViewController.h"
#import "BFOrderPageTableViewCell.h"
#import "BFOrderModel.h"
#import "BFOrderPageOrderInfoViewController.h"
@interface BFOrderPageTableViewController ()<UITableViewDelegate,UITableViewDataSource,BFOrderPageTableViewCellDelegate>
@property (nonatomic, strong)NSMutableArray <BFOrderModel *> *orderModelArray;
@end
static NSString *cellid = @"BFOrderPageTableViewController";
@implementation BFOrderPageTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![BFAccountManager getUserDefaultObject:@"userid"]) {
        [SVProgressHUD showInfoWithStatus:@"Please login first"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    [self getFoodOrderDataListWithIndex:_index + 1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.orderModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BFOrderPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    cell.model = self.orderModelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delelgate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BFOrderPageOrderInfoViewController *orderInfoVc = [[BFOrderPageOrderInfoViewController alloc] init];
    orderInfoVc.model = self.orderModelArray[indexPath.row];
    orderInfoVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderInfoVc animated:YES];
}

- (void)orderPageTableViewCell:(BFOrderPageTableViewCell *)orderPageTableViewCell andCancelModel:(BFOrderModel *)model {
    
    NSDictionary *parameters = @{@"orderid":model.userorderid,@"buyuserid":model.buyuserid,@"usetype":model.usetype};
    
    [JLNetWorking POST:@"/order/cancelOrder" parameters:parameters httpSuccess:^(NSDictionary *dict) {
        
        [self.orderModelArray removeObject:model];
        [self.tableView reloadData];
    } httpFailed:^(NSString *error) {
        
    }];
    
}


- (void)getFoodOrderDataListWithIndex:(NSInteger)index {
    
    NSString *businessid = [BFAccountManager getUserDefaultObject:@"userid"];
    NSString *usetype = [BFAccountManager getUserDefaultObject:@"usetype"];
    NSInteger iden = 1;
    
    NSDictionary *parameters = @{@"businessid":businessid,@"usetype":usetype,@"iden":@(iden),@"orderstate":@(index)};
    
    [JLNetWorking POST:@"/order/orderStateList" parameters:parameters httpSuccess:^(NSDictionary *dict) {
        
        self.orderModelArray = [BFOrderModel mj_objectArrayWithKeyValuesArray:Data];
        
        [self.tableView reloadData];
        
    } httpFailed:^(NSString *error) {
        
    }];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"BFOrderPageTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
        _tableView.estimatedRowHeight = 150;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    
    return _tableView;
}

- (NSMutableArray<BFOrderModel *> *)orderModelArray{
    if (!_orderModelArray) {
        _orderModelArray = [NSMutableArray array];
    }
    return _orderModelArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
