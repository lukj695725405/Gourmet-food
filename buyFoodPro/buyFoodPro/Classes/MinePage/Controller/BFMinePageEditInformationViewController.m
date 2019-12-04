//
//  BFMinePageEditInformationViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFMinePageEditInformationViewController.h"
#import "ZZQAvatarPicker.h"
@interface BFMinePageEditInformationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *userAge;
@property (weak, nonatomic) IBOutlet UITextField *userSex;
@property (weak, nonatomic) IBOutlet UITextField *userPhone;
@property (weak, nonatomic) IBOutlet UITextField *recordGoodMood;

@property (weak, nonatomic) IBOutlet UILabel *userNameText;
@property (weak, nonatomic) IBOutlet UILabel *userAgeText;
@property (weak, nonatomic) IBOutlet UILabel *userSexText;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneText;
@property (weak, nonatomic) IBOutlet UILabel *userGoodHeatText;

@property (weak, nonatomic) IBOutlet UIButton *uploadIconBtnText;



@end

@implementation BFMinePageEditInformationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //添加通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardMiss:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.title = NSLocalizedString(@"The editor", nil);
    self.userNameText.text = NSLocalizedString(_userNameText.text, nil);
    self.userAgeText.text = NSLocalizedString(_userAgeText.text, nil);
    self.userSexText.text = NSLocalizedString(_userSexText.text, nil);
    self.userPhoneText.text = NSLocalizedString(_userPhoneText.text, nil);
    self.userGoodHeatText.text = NSLocalizedString(_userGoodHeatText.text, nil);
    [self.uploadIconBtnText setTitle:NSLocalizedString(_uploadIconBtnText.titleLabel.text, nil) forState:UIControlStateNormal];
    self.userNameTF.placeholder = NSLocalizedString(_userNameTF.placeholder, nil);
    self.userPhone.placeholder = NSLocalizedString(_userPhone.placeholder, nil);
    self.userAge.placeholder = NSLocalizedString(_userAge.placeholder, nil);
    self.userSex.placeholder = NSLocalizedString(_userSex.placeholder, nil);
    self.recordGoodMood.placeholder = NSLocalizedString(_recordGoodMood.placeholder, nil);
    
   
    self.userNameTF.text = _model.nickname;
    self.userAge.text = _model.age;
    
    if ([_model.sex integerValue] == 0) {
        self.userSex.text = @"boy";
    }else {
        self.userSex.text = @"girl";
    }
    
    self.userPhone.text = _model.phonenum;
    
    
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 40;
    self.recordGoodMood.text = _model.extend1;
    
    
    if (self.model.avatar == nil) {
        self.iconImageView.image = [UIImage imageNamed:@"yonghudenglu"];
    }else {
        
        NSString *url = @"https://maochong.oss-cn-hangzhou.aliyuncs.com/";
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,self.model.avatar]]];
    }
    
    UIBarButtonItem *rightBarBtn  = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"save", nil) style:(UIBarButtonItemStylePlain) target:self action:@selector(saveEidtAction)];
    
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    
}


- (void)saveEidtAction {
    
    if (self.iconImageView.image == nil){
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Please set the avatar", nil)];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    if(self.userNameTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Please set the user name", nil)];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }

    if (self.userAge.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Please set the age", nil)];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    if (self.userSex.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Please set gender", nil)];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    if (self.recordGoodMood.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Please set a good mood", nil)];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    [self updateUserInfoData];
}


- (IBAction)updateIconBtnAction:(id)sender {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [ZZQAvatarPicker startSelected:^(UIImage * _Nonnull image) {
        if (image) {
            
            self.iconImageView.image = image;
            
        }
    }];
}


- (void)updateUserInfoData {
    NSData *imageData = UIImageJPEGRepresentation(self.iconImageView.image,0.4);
    
    
    NSString *userid = [BFAccountManager getUserDefaultObject:@"userid"];
    NSString *usetype = [BFAccountManager getUserDefaultObject:@"usetype"];
    NSString *extend1 = self.recordGoodMood.text;
    NSInteger sex = 1;// 女
    if ([self.userSex.text isEqualToString:@"boy"]) {
        sex = 0;// 男
    }
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Are modified", nil)];
    
    NSDictionary *parameters = @{@"userid":userid,@"usetype":usetype,@"name":self.userNameTF.text,@"phonenum":self.userPhone.text,@"age":self.userAge.text,@"sex":@(sex),@"iden":@(1),@"extend1":extend1,@"file":@""};
    
    [JLNetWorking uploadImage:@"/user/updateUserInfo" parameters:parameters imageData:imageData progress:^(NSProgress *uploadProgress) {
        
        NSLog(@"上传的进度========%f",uploadProgress.fractionCompleted);
        
    } httpSuccess:^(NSDictionary *dict) {
        
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Modify the success", nil)];
        [SVProgressHUD dismissWithDelay:1.0 completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        
    } httpFailed:^(NSString *error) {
        
    }];
    
}

////回收键盘改变控制器view
//-(void)keyboardMiss:(NSNotification *)noti{
//    self.view.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenW, ScreenH);
//}
//// 弹出键盘改变控制器view
//-(void)keyboardShow:(NSNotification *)noti{
//    CGRect keyboardRect = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    self.view.frame = CGRectMake(0, -30, ScreenW, ScreenH);
//}
//
//- (IBAction)tapKeyBoardDownAction:(id)sender {
//
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
