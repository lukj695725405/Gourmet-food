//
//  BFAddAddressViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFAddAddressViewController.h"

@interface BFAddAddressViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameLb;
@property (weak, nonatomic) IBOutlet UITextField *phoneLb;
@property (weak, nonatomic) IBOutlet UITextField *addressLb;
@property (weak, nonatomic) IBOutlet UITextField *postalLb;

@property (weak, nonatomic) IBOutlet UILabel *nameText;
@property (weak, nonatomic) IBOutlet UILabel *phoneText;
@property (weak, nonatomic) IBOutlet UILabel *addressText;
@property (weak, nonatomic) IBOutlet UILabel *diCoedText;
@property (weak, nonatomic) IBOutlet UIButton *commitBtnText;

@end

@implementation BFAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.nameLb.placeholder = _nameLb.placeholder;
    self.phoneLb.placeholder = _phoneLb.placeholder;
    self.addressLb.placeholder = _addressLb.placeholder;
    self.postalLb.placeholder = _postalLb.placeholder;
    
    self.nameText.text = _nameText.text;
    self.phoneText.text = _phoneText.text;
    self.addressText.text = _addressText.text;
    self.diCoedText.text = _diCoedText.text;
    [self.commitBtnText setTitle:_commitBtnText.titleLabel.text forState:UIControlStateNormal];
    self.title = @"Add consignee";
}

- (void)addAdressData {
    
    NSString *userid = [BFAccountManager getUserDefaultObject:@"userid"];
    NSString *usetype = [BFAccountManager getUserDefaultObject:@"usetype"];
    
    NSDictionary *parameters = @{@"userid":userid,@"usetype":usetype,@"address":self.addressLb.text,@"phone":self.phoneLb.text,@"postcode":self.postalLb.text,@"name":self.nameLb.text};
    __weak typeof(self) weakSelf = self;
    [JLNetWorking POST:@"/address/addAddress" parameters:parameters httpSuccess:^(NSDictionary *dict) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    } httpFailed:^(NSString *error) {
        
    }];
    
}

- (IBAction)addAdressAction:(id)sender {
    if (self.nameLb.text.length == 0 || self.phoneLb.text.length == 0  || self.addressLb.text.length == 0 || self.postalLb.text.length ==0) {
        [SVProgressHUD showInfoWithStatus:@"You need to fill in all of these"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    [self addAdressData];
}
- (void)blackAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
