//
//  BFBaseViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/13.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFBaseViewController ()

@end

@implementation BFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.95 green:0.83 blue:0.23 alpha:1.00];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.subviews[0].subviews[0].hidden = YES;
   
    [self setupUI];
}

- (void)setupUI {
    
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
