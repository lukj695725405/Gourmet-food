//
//  BFOrderPageViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/13.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFOrderPageViewController.h"
#import "YNPageViewController.h"
#import "BFOrderPageTableViewController.h"
@interface BFOrderPageViewController ()<YNPageViewControllerDataSource, YNPageViewControllerDelegate>

@end

@implementation BFOrderPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupUI {
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    
    configration.pageStyle = YNPageStyleSuspensionTopPause;
    configration.headerViewCouldScale = YES;
    /// 控制tabbar 和 nav
    configration.showTabbar = YES;
    configration.showNavigation = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = YES;
    
    /// 设置悬浮停顿偏移量
    configration.suspenOffsetY = NAVIGATION_BAR_HEIGHT;
    /// menu相关设置
    configration.menuHeight = 65;
    configration.selectedItemColor = [UIColor colorWithRed:0.95 green:0.83 blue:0.23 alpha:1.00];
    configration.selectedItemFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    configration.lineColor = [UIColor colorWithRed:0.95 green:0.83 blue:0.23 alpha:1.00];
    
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    
    
    YNPageViewController *vc = [YNPageViewController pageViewControllerWithControllers:[self getController] titles:[self getTitleName] config:configration];
    vc.dataSource = self;
    vc.delegate = self;
    
    vc.pageIndex = 0;
    vc.headerView = [UIView new];
    [vc addSelfToParentViewController:self];
    
    
}
- (NSArray *)getTitleName {
    
    return @[@"Waiting to be processed",@"Wait for the delivery",@"Already sent the goods",@"Order finished"];
}

- (NSArray *)getController {
    NSMutableArray *controllArrayM = [NSMutableArray array];
    for (int i = 0; i < [self getTitleName].count; i++) {
        BFOrderPageTableViewController *vc = [[BFOrderPageTableViewController alloc] init];
        vc.index = i;
        [controllArrayM addObject:vc];
    }
    return controllArrayM.copy;
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    
    BFOrderPageTableViewController *vc = pageViewController.controllersM[index];
    
    return [vc tableView];
    
}

#pragma mark - YNPageViewControllerDelegate
- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffset
                  progress:(CGFloat)progress {
    NSLog(@"--- contentOffset = %f, progress = %f", contentOffset, progress);
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
