//
//  BFLoginViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/13.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFLoginViewController.h"
#import "NSString+Extension.h"
#import "BFRegisterViewController.h"
#import "BFUserModel.h"
@interface BFLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *userPhone;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@end

@implementation BFLoginViewController{
    NSTimer *_timer;
    NSInteger _number;
    NSString *_phoneNumber;
    NSString *_verityCode;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //写入这个方法后,这个页面将没有这种效果
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    //    [self setKeyboardDistanceFromTextField:10.0];
    [[IQKeyboardManager sharedManager]setKeyboardDistanceFromTextField:20.0];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //最后还设置回来,不要影响其他页面的效果
    [IQKeyboardManager sharedManager].enable = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI {
    
//    self.userPhone.delegate = self;
}

- (IBAction)backBtnAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerBtnAction:(id)sender {
    
    BFRegisterViewController *registerVc = [[BFRegisterViewController alloc] init];
    
    [self presentViewController:registerVc animated:YES completion:nil];
}


- (IBAction)loginBtnAction:(id)sender {
    
    if ([self checkLoginRequestInfo]) {
        
        //手机号登录
        NSString * phone = self.userPhone.text;
        
        NSString * password = self.userPassword.text;
        
        NSString * usetype = @"3776";
        
        NSDictionary *paramet = @{@"phone":phone,@"password":password,@"usetype":usetype};
        
        
        [JLNetWorking POST:@"user/userLogin" parameters:paramet httpSuccess:^(NSDictionary *dict) {
            //
            BFUserModel *model = [BFUserModel mj_objectWithKeyValues:dict[@"data"]];
            
            if ([dict[@"code"] integerValue] == 10001) {
                if ([dict[@"msg"] isEqualToString:@"当前用户不存在"]) {
                    [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Account does not exist", nil)];
                }else if([dict[@"msg"] isEqualToString:@"用户密码不正确"]) {
                    [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Incorrect password", nil)];
                }
            }else if([dict[@"code"] integerValue] == 10000) {
                if ([Data[@"iden"] integerValue] == 1) {
                    
                    [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Login successful", nil)];
                    //获得文件路径
                    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                    NSString *filePath = [documentPath stringByAppendingPathComponent:@"file.archiver"];
                    if ([NSKeyedArchiver archiveRootObject: model toFile:filePath]) {
                        NSLog(@"Archiver  success");
                    }
                    
                    [BFAccountManager saveUserDefaultObject:self.userPhone.text key:@"iphoneNum"];
                    [BFAccountManager saveUserDefaultObject:self.userPassword.text key:@"passwordNum"];
                    [BFAccountManager saveUserDefaultObject:usetype key:@"usetype"];
                    
                    NSString *createtime = Data[@"createtime"];
                    NSString *nickname = Data[@"nickname"];
                    NSString *phonenum = Data[@"phonenum"];
                    NSArray *array = @[nickname,phonenum,createtime];
                    
                    [BFAccountManager saveUserDefaultObject:array key:@"array"];
                    [BFAccountManager saveUserDefaultObject:Data[@"userid"] key:@"userid"];
                    //                    //切换到主页
                    //                    UIApplication * application = [UIApplication sharedApplication];
                    //
                    //                    SFBaseTabBarController * homePage = [[SFBaseTabBarController alloc] init];
                    //
                    //                    application.delegate.window.rootViewController = homePage;
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    
                    [self.view removeFromSuperview];
                }else {
                    [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Account does not exist", nil)];
                }
            }
            [SVProgressHUD dismissWithDelay:1.0];
        } httpFailed:^(NSString *error) {
            [SVProgressHUD dismissWithDelay:1.0];
        }];   
    }
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"%@------------%@",textField.text,string);
    
    //手机号位数限制
    if (textField == self.userPhone) {
        
        if (textField.text.length + string.length > 11){
            
            
            [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Please enter an 11-digit mobile phone number", nil)];
            [SVProgressHUD dismissWithDelay:1.0];
        }
        return textField.text.length + string.length <= 11;
    }
    
    return YES;
}

- (BOOL)checkLoginRequestInfo {
    
    _phoneNumber= [self.userPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (self.userPhone.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Please enter your mobile phone number", nil)];
        [SVProgressHUD dismissWithDelay:1.0];
        return NO;
    }
    
    
//    if (![_phoneNumber phoneIs11Numbers]) {
//        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Please enter a valid mobile phone number", nil)];
//        [SVProgressHUD dismissWithDelay:1.0];
//        return NO;
//    }
    
    
//    if (self.userPhone.text.length < 11) {
//        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Please enter the correct 11-digit mobile phone number", nil)];
//        [SVProgressHUD dismissWithDelay:1.0];
//        return NO;
//    }
    
    
    if (self.userPassword.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Please enter password", nil)];
        [SVProgressHUD dismissWithDelay:1.0];
        return NO;
    }
    
    return YES;
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
