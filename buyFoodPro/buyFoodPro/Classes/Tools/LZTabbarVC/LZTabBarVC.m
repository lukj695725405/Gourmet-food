//
//  LZTabBarVC.m
//  WebViewTest
//
//  Created by 刘转 on 2019/3/4.
//  Copyright © 2019年 刘转. All rights reserved.
//

#import "LZTabBarVC.h"
#import "LZCustomTabbar.h"

@interface LZTabBarVC ()

@end

@implementation LZTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self initUI];
}
- (void)initUI
{
   
    LZCustomTabbar * tabbar = [[LZCustomTabbar alloc] init];
    //中间自定义tabBar点击事件
    __weak __typeof(self) weakSelf = self;
    tabbar.btnClickBlock = ^(UIButton *btn) {
        __typeof(&*weakSelf) strongSelf = weakSelf;
        strongSelf.selectedIndex = 4;
    };
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
 
 
    //第一个控制器
    UIViewController * vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    UINavigationController * NC1 = [self addChildVc:vc1 title:@"首页" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    //第2个控制器
    UIViewController * vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor yellowColor];
    UINavigationController * NC2 = [self addChildVc:vc2 title:@"课程" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    //第3个控制器
    UIViewController * vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor blueColor];
    UINavigationController * NC3 = [self addChildVc:vc3 title:@"收藏" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    //第4个控制器
    UIViewController * vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor purpleColor];
    UINavigationController * NC4 = [self addChildVc:vc4 title:@"我的" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //第5个控制器
    UIViewController * vc5 = [[UIViewController alloc] init];
    vc5.view.backgroundColor = [UIColor whiteColor];
    vc5.title = @"中间";
    UINavigationController * NC5 = [[UINavigationController alloc] initWithRootViewController:vc5];
     self.viewControllers = @[NC1,NC2,NC3,NC4,NC5];
}
#pragma mark - 添加子控制器  设置图片
/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (UINavigationController*)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色  system为系统字体
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont fontWithName:nil size:13]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:nil size:13]} forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    return nav;
}
#pragma mark - 类的初始化方法，只有第一次使用类的时候会调用一次该方法
+ (void)initialize
{
    //tabbar去掉顶部黑线
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [LZCustomTabbar setTabBarUI:self.tabBar.subviews tabBar:self.tabBar topLineColor:[UIColor lightGrayColor] backgroundColor:self.tabBar.barTintColor];
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
