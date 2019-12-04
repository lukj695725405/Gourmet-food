//
//  BFHomePagePlaceTheOrderViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFHomePagePlaceTheOrderViewController.h"
#import "BFAddressListViewController.h"
#import "BFHomePageViewController.h"
@interface BFHomePagePlaceTheOrderViewController ()
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *foodPrice;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPhone;
@property (weak, nonatomic) IBOutlet UITextField *userAddress;
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *foodImageH;

@end

@implementation BFHomePagePlaceTheOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI {
    
    self.navigationItem.title = @"Place Order";
    
    self.foodName.text = _model.goodname;
    self.foodPrice.text = [NSString stringWithFormat:@"¥ %@",_model.goodprice];
    NSString *url = @"https://maochong.oss-cn-hangzhou.aliyuncs.com/";
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_model.goodimage]]]];
    self.foodImageH.constant = image.size.height / image.size.width * ScreenW;
    
    self.foodImageView.image = image;
    
}


- (IBAction)chooseBtnAction:(id)sender {
    
    BFAddressListViewController *addressListVc = [[BFAddressListViewController alloc] init];
    addressListVc.hidesBottomBarWhenPushed = YES;
    [addressListVc setPeasantModelBlock:^(BFAddressModel * _Nonnull model) {
        self.userName.text = model.name;
        self.userPhone.text = model.phone;
        self.userAddress.text = model.address;
    }];
    [self.navigationController pushViewController:addressListVc animated:YES];
    
}
- (IBAction)placeOrderBtnAction:(id)sender {
    
    if ([self cheackAppointmentUserInfo]) {
        
        NSString *buyuserid = [BFAccountManager getUserDefaultObject:@"userid"];
        NSString *usetype = [BFAccountManager getUserDefaultObject:@"usetype"];
        NSString *saleuserid = _model.userid;
        NSString *goodid = _model.goodid;
        NSString *receivename = self.userName.text;
        NSString *receivephone = self.userPhone.text;
        NSString *receiveaddress = self.userAddress.text;
        
        
        [JLNetWorking POST:@"/order/sendOrder" parameters:@{@"buyuserid":buyuserid,@"usetype":usetype,@"saleuserid":saleuserid,@"goodid":goodid,@"receivename":receivename,@"receivephone":receivephone,@"receiveaddress":receiveaddress} httpSuccess:^(NSDictionary *dict) {
            
            
            [SVProgressHUD showInfoWithStatus:@"Place an order successfully"];
            [SVProgressHUD dismissWithDelay:1.0 completion:^{
                
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[BFHomePageViewController class]]) {
                        BFHomePageViewController *homePage =(BFHomePageViewController *)controller;
                        [self.navigationController popToViewController:homePage animated:YES];
                    }
                }
                
            }];
            
        } httpFailed:^(NSString *error) {
            
        }];
        
    }
}

- (BOOL)cheackAppointmentUserInfo {
    if (self.userName.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"Please enter contact name"];
        [SVProgressHUD dismissWithDelay:1.0];
        return NO;
    }
    if (self.userPhone.text.length == 0 && self.userPhone.text.length != 11) {
        [SVProgressHUD showInfoWithStatus:@"Please enter the correct contact phone number"];
        [SVProgressHUD dismissWithDelay:1.0];
        return NO;
    }
    if (self.userAddress.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"Please enter the contact address"];
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
