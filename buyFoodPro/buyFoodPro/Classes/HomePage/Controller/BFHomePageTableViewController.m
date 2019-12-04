//
//  BFHomePageTableViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFHomePageTableViewController.h"
#import "BFFoodModel.h"
#import "BFHomePageTableViewCell.h"
#import "BFHomePageFoodInfoViewController.h"
@interface BFHomePageTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray<BFFoodModel *> *foodModelArray;
@end
static NSString *cellid = @"BFHomePageTableViewController";
@implementation BFHomePageTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
     [self getFoodDataListWithTitleName:_textName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupUI {
    
    [self.view addSubview:self.tableView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.foodModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BFHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    cell.model = self.foodModelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BFHomePageFoodInfoViewController *foodInfoVc = [[BFHomePageFoodInfoViewController alloc] init];
    foodInfoVc.model = self.foodModelArray[indexPath.row];
    foodInfoVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:foodInfoVc animated:YES];
    
}


- (void)getFoodDataListWithTitleName:(NSString *)titleName {
    
    [JLNetWorking POST:@"/business/allGoods" parameters:@{@"usetype":@"3776"} httpSuccess:^(NSDictionary *dict) {
        self.foodModelArray = [BFFoodModel mj_objectArrayWithKeyValuesArray:Data];
        for (BFFoodModel *model in self.foodModelArray.copy) {
            if (![model.extend1 isEqualToString:titleName]) {
                [self.foodModelArray removeObject:model];
            }
        }
        [self.tableView reloadData];
        
        
    } httpFailed:^(NSString *error) {
        
    }];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"BFHomePageTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
        _tableView.estimatedRowHeight = 100;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    
    return _tableView;
}

- (NSMutableArray<BFFoodModel *> *)foodModelArray {
    if (!_foodModelArray) {
        _foodModelArray = [NSMutableArray array];
    }
    return _foodModelArray;
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
