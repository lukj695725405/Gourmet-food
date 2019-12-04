//
//  BFBaseTabBarController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/13.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFBaseTabBarController.h"

@interface BFBaseTabBarController ()

@end

@implementation BFBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIViewController *v1 = [self loadTabBarWithClassName:@"BFHomePageViewController" andImageName:@"shouye" andTitle:@"Home"];
    
    UIViewController *v2 = [self loadTabBarWithClassName:@"BFOrderPageViewController" andImageName:@"dingdan" andTitle:@"Order"];
    
    
    UIViewController *v3 = [self loadTabBarWithClassName:@"BFMinePageInformationViewController" andImageName:@"wode" andTitle:@"Mine"];
    
    
    self.viewControllers = @[v1,v2,v3];
    
}
- (UIViewController *)loadTabBarWithClassName:(NSString *)className andImageName:(NSString *)imageName andTitle:(NSString *)title {
    
    Class class = NSClassFromString(className);
    UIViewController *vc = (UIViewController *) [[class alloc] init];
    
    vc.title = title;
    
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@-S", imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *dict = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00]};
    //    [[UITabBarItem appearance] setTitleTextAttributes:dict forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    return nav;
    
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
