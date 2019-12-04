//
//  BFHomePageViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/13.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFHomePageViewController.h"
#import "BFHomePageHeaderView.h"
#import "YNPageViewController.h"
#import "BFHomePageTableViewController.h"
@interface BFHomePageViewController ()<YNPageViewControllerDataSource, YNPageViewControllerDelegate>

@end

@implementation BFHomePageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    
    configration.pageStyle = YNPageStyleSuspensionTop;
    configration.headerViewCouldScale = YES;
    /// 控制tabbar 和 nav
    configration.showTabbar = YES;
    configration.showNavigation = YES;
    configration.aligmentModeCenter = YES;
    configration.lineWidthEqualFontWidth = YES;
    
    
    /// 设置悬浮停顿偏移量
    configration.suspenOffsetY = NAVIGATION_BAR_HEIGHT;
    /// menu相关设置
    configration.menuHeight = 65;
    configration.selectedItemColor = [UIColor colorWithHue:0.92 saturation:0.76 brightness:0.79 alpha:1.00];
    configration.selectedItemFont = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    configration.lineColor = [UIColor colorWithHue:0.92 saturation:0.76 brightness:0.79 alpha:1.00];
    configration.aligmentModeCenter = NO;
    configration.scrollViewBackgroundColor = [UIColor whiteColor];
    
    
    YNPageViewController *vc = [YNPageViewController pageViewControllerWithControllers:[self getController] titles:[self getTitleName] config:configration];
    vc.dataSource = self;
    vc.delegate = self;
    
    vc.pageIndex = 0;
    BFHomePageHeaderView *headView = [BFHomePageHeaderView homePageHeaderView];
    headView.frame = CGRectMake(0, 0, ScreenW, 240);
    vc.headerView = headView;
    [vc addSelfToParentViewController:self];
    
    
    
}
- (NSArray *)getTitleName {
    
    
    return @[@"Breakfast",@"Lunch",@"Dinners",@"Desserts"];
}

- (NSArray *)getController {
    NSMutableArray *controllArrayM = [NSMutableArray array];
    for (int i = 0; i < [self getTitleName].count; i++) {
        BFHomePageTableViewController *vc = [[BFHomePageTableViewController alloc] init];
        vc.textName = [self getTitleName][i];
        //        vc.businessModel = self.model;
        vc.index = i;
        [controllArrayM addObject:vc];
    }
    return controllArrayM.copy;
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    
    BFHomePageTableViewController *vc = pageViewController.controllersM[index];
    
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
