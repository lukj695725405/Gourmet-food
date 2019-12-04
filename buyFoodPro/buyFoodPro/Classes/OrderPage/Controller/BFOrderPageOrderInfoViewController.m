//
//  BFOrderPageOrderInfoViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFOrderPageOrderInfoViewController.h"

@interface BFOrderPageOrderInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mikeTeaImageH;
@property (weak, nonatomic) IBOutlet UIImageView *mikeTeaImageView;
@property (weak, nonatomic) IBOutlet UILabel *mikeTeaName;
@property (weak, nonatomic) IBOutlet UILabel *mikeTeaDesc;

@property (weak, nonatomic) IBOutlet UILabel *orderId;
@property (weak, nonatomic) IBOutlet UILabel *orderCreateTime;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UILabel *userAddress;
@end

@implementation BFOrderPageOrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI {
    
    self.navigationItem.title = @"Milk tea reservation details";
    
    NSString *url = @"https://maochong.oss-cn-hangzhou.aliyuncs.com/";
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_model.tyGoods.goodimage]]]];
    self.mikeTeaImageH.constant = image.size.height / image.size.width * ScreenW;
    [self.mikeTeaImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_model.tyGoods.goodimage]]];
    self.mikeTeaName.text = _model.tyGoods.goodname;
    self.mikeTeaDesc.text = _model.tyGoods.extend3;
    self.orderId.text = _model.userorderid;
    self.orderCreateTime.text = _model.createtime;
    
    self.userPhone.text = _model.receivephone;
    self.userAddress.text = _model.receiveaddress;
    self.userName.text = _model.receivename;
    
    
    if ([_model.orderstate integerValue] == 1) {
        self.orderStatus.text = @"Waiting to be processed";
        
    }else if ([_model.orderstate integerValue] == 2) {
        self.orderStatus.text = @"Wait for the delivery";
    }else if ([_model.orderstate integerValue] == 3) {
        self.orderStatus.text = @"Already sent the goods";
    }else {
        self.orderStatus.text = @"Order finished";
    }
    
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
