//
//  BFIngredientsViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFIngredientsViewController.h"
#import "BFIngredientsTableViewCell.h"
@interface BFIngredientsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *array;
@end
static NSString *cellid = @"BFIngredientsViewController";
@implementation BFIngredientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupUI {
    
    [self.view addSubview:self.tableView];
    self.array = [_ingredientsStr componentsSeparatedByString:@"￥"];
    self.navigationItem.title = _titleName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BFIngredientsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    
    cell.number.text = [NSString stringWithFormat:@"%02zd",indexPath.row + 1];
    cell.context.text = self.array[indexPath.row];
    return cell;
    
}
  
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"BFIngredientsTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
        _tableView.estimatedRowHeight = 30;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    
    return _tableView;
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
