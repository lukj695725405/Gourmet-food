//
//  BFRegisterViewController.m
//  foodPro
//
//  Created by Lukj on 2019/11/13.
//  Copyright © 2019 foodPro. All rights reserved.
//

#import "BFRegisterViewController.h"
#import "NSString+Extension.h"
@interface BFRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userPhone;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UITextField *userSurePassword;
@end

@implementation BFRegisterViewController{
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

- (IBAction)registerBtnAction:(id)sender {
    
    
    NSString * usetype = @"3776";
    
    NSString * phonenum = self.userPhone.text;
    
    NSString * password = self.userPassword.text;
    
    NSString * sureRegisterPassword = self.userSurePassword.text;
    
    NSInteger iden = 1;
    
    if ([self checkRegisterRequestInfo]) {
        
        
        NSDictionary *paramets = @{@"phonenum":phonenum,@"password":sureRegisterPassword,@"iden":@(iden),@"usetype":usetype};
        
        [JLNetWorking POST:@"user/userRegister" parameters:paramets httpSuccess:^(NSDictionary *dict) {
            if ([dict[@"code"] integerValue] == 10000) {
                
                [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Registered successfully", nil)];
                [BFAccountManager saveUserDefaultObject:phonenum key:@"phonenum"];
                [BFAccountManager saveUserDefaultObject:password key:@"password"];
                
                [SVProgressHUD dismissWithDelay:1.0 completion:^{
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }];
            }else if([dict[@"code"] integerValue] == 10001) {
                
                [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Has been registered", nil)];
                [SVProgressHUD dismissWithDelay:1.0];
            }
            
            
            
        } httpFailed:^(NSString *error) {
            [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"The Internet doesn't work", nil)];
        }];
        
        
        
    }
}


- (BOOL)checkRegisterRequestInfo {
    
//    _phoneNumber= [self.userPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
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
//
    
//    if (self.userPhone.text.length < 11) {
//        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Please enter the correct 11-digit mobile phone number", nil)];
//        [SVProgressHUD dismissWithDelay:1.0];
//        return NO;
//    }
//
    
    if (self.userPassword.text.length == 0 && self.userSurePassword.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Please enter password and confirm password", nil)];
        [SVProgressHUD dismissWithDelay:1.0];
        return NO;
    }
    
    
    if (![self.userPassword.text isEqualToString:self.userSurePassword.text]) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"The two passwords are different, please enter again", nil)];
        [SVProgressHUD dismissWithDelay:1.0];
        return NO;
    }
    
    return YES;
    
    
}


- (IBAction)backBtnAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
