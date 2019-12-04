//
//  BFMinePageInformationViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFMinePageInformationViewController.h"
#import "BFLoginViewController.h"
#import "BFUserModel.h"
#import "BFMinePageEditInformationViewController.h"
#import "BFAddressListViewController.h"
@interface BFMinePageInformationViewController ()
@property (strong, nonatomic) UIAlertAction *okAction;
@property (strong, nonatomic) UIAlertAction *cancelAction;
@property (weak, nonatomic) IBOutlet UILabel *versionLb;

@property (weak, nonatomic) IBOutlet UIImageView *userImge;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *loginLb;
@property (weak, nonatomic) IBOutlet UILabel *loginText;

@property (nonatomic, strong)BFUserModel *userModel;
@property (weak, nonatomic) IBOutlet UIImageView *mineBackgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mineBackgroundH;

@property (weak, nonatomic) IBOutlet UILabel *myInfoText;
@property (weak, nonatomic) IBOutlet UILabel *addressText;
@property (weak, nonatomic) IBOutlet UILabel *versionText;


@end

@implementation BFMinePageInformationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    if (![BFAccountManager getUserDefaultObject:@"userid"]) {
        
        self.loginLb.text = NSLocalizedString(@"Login", nil);
        self.loginText.hidden = NO;
        self.userImge.image = [UIImage imageNamed:@"yonghudenglu"];
        self.userName.text = @"";
        self.goodTime.text = @"";
    }else {
        
        self.loginLb.text = NSLocalizedString(@"Exit", nil);
        self.loginText.hidden = YES;
        
        [self getUserInfoData];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI {
    

    UIImage *image = [UIImage imageNamed:@"mineTopImageView"];
    self.mineBackgroundH.constant = image.size.height / image.size.width *ScreenW;
    self.mineBackgroundImageView.image = image;
    
    self.mineBackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.mineBackgroundImageView.clipsToBounds = YES;
    
    self.versionLb.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.loginLb.text = NSLocalizedString(_loginLb.text, nil);
    self.loginText.text = NSLocalizedString(_loginText.text, nil);
    self.myInfoText.text = NSLocalizedString(_myInfoText.text, nil);
    self.addressText.text = NSLocalizedString(_addressText.text, nil);
    self.versionText.text = NSLocalizedString(_versionText.text, nil);
}



// 个人资料
- (IBAction)mySelfInfoBtnAction:(id)sender {
    if (![BFAccountManager getUserDefaultObject:@"userid"]) {
        
        [SVProgressHUD showInfoWithStatus:@"Please login first"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    BFMinePageEditInformationViewController *myInfoEdit = [[BFMinePageEditInformationViewController alloc] init];
    myInfoEdit.model = self.userModel;
    myInfoEdit.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myInfoEdit animated:YES];
}
// 收货地址
- (IBAction)myAddressBtnAction:(id)sender {
    if (![BFAccountManager getUserDefaultObject:@"userid"]) {
        
        [SVProgressHUD showInfoWithStatus:@"Please login first"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    BFAddressListViewController *addressList = [[BFAddressListViewController alloc] init];
    addressList.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addressList animated:YES];
}

// 退出登录
- (IBAction)exitBtnAction:(id)sender {
    
    if ([BFAccountManager getUserDefaultObject:@"userid"]) {
        // 退出
        [self logout];
    }else {
        // 登录
        
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
    
}
- (void) logout {
    
    //     初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Prompt", nil) message:NSLocalizedString(@"Are you sure to log out the current user?", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    _okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Determine", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        
        [BFAccountManager removeObjectWithKey:@"userid"];
        [BFAccountManager removeObjectWithKey:@"usetype"];
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }];
    _cancelAction =[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    
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


- (void)getUserInfoData {
    

    
    NSString *userid = [BFAccountManager getUserDefaultObject:@"userid"];
    NSString *usetype = [BFAccountManager getUserDefaultObject:@"usetype"];
    
    
    [JLNetWorking POST:@"/user/userInfo" parameters:@{@"usetype":usetype,@"userid":userid} httpSuccess:^(NSDictionary *dict) {
        
        self.userModel = [BFUserModel mj_objectWithKeyValues:Data];
        
        if (self.userModel.avatar == nil) {
            self.userImge.image = [UIImage imageNamed:@"yonghudenglu"];
        }else {
            
            NSString *url = @"https://maochong.oss-cn-hangzhou.aliyuncs.com/";
            [self.userImge sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,self.userModel.avatar]]];
        }
        self.userImge.layer.cornerRadius = 40;
        self.userImge.layer.masksToBounds = YES;
        self.userName.text = self.userModel.nickname;
        self.goodTime.text = self.userModel.extend1;
    } httpFailed:^(NSString *error) {
        
    }];
    
}

//解归档
//- (BFUserModel *)unarchive {
//    if ([BFAccountManager getUserDefaultObject:@"userid"]) {
//        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *filePath = [documentPath stringByAppendingPathComponent:@"file.archiver"];
//        //解归档（反序列化）
//        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    }else {
//
//        return nil;
//
//    }
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
