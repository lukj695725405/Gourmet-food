//
//  BFMinePageViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/13.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFMinePageViewController.h"
#import "BFLoginViewController.h"
@interface BFMinePageViewController ()
@property (strong, nonatomic) UIAlertAction *okAction;
@property (strong, nonatomic) UIAlertAction *cancelAction;
@end

@implementation BFMinePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupUI {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(clickBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
    
- (void)clickBtnAction {
    
    [self logout];
        
}
    
- (void) logout {
    
    //     初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Prompt" message:@"Are you sure to log out the current user?" preferredStyle:UIAlertControllerStyleAlert];
    
    _okAction = [UIAlertAction actionWithTitle:@"Determine" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        
        [BFAccountManager removeObjectWithKey:@"userid"];
        [BFAccountManager removeObjectWithKey:@"usetype"];
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }];
    _cancelAction =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:_okAction];
    [alert addAction:_cancelAction];
    
    [self performSelectorOnMainThread:@selector(WakeUpTheMainThread) withObject:nil waitUntilDone:NO];
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
        
    });
    
}
    
    
- (void)WakeUpTheMainThread {
    
    
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
