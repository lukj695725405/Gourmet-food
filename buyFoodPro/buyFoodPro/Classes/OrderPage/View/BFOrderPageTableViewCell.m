//
//  BFOrderPageTableViewCell.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFOrderPageTableViewCell.h"

@interface BFOrderPageTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *footName;
@property (weak, nonatomic) IBOutlet UILabel *foodDesc;
@property (weak, nonatomic) IBOutlet UILabel *foodPrice;
@property (weak, nonatomic) IBOutlet UILabel *userAddress;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation BFOrderPageTableViewCell

- (void)setModel:(BFOrderModel *)model {
    _model = model;
    NSString *url = @"https://maochong.oss-cn-hangzhou.aliyuncs.com/";
    [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,model.tyGoods.goodimage]]];
    
    self.footName.text = model.tyGoods.goodname;
    self.foodDesc.text = model.tyGoods.extend3;
    self.foodPrice.text = [NSString stringWithFormat:@"¥ %@",model.tyGoods.goodprice];
    self.userAddress.text = model.receiveaddress;
   
    if ([model.orderstate integerValue] == 1) {
        self.cancelBtn.hidden = NO;
        self.orderStatus.text = @"To be processed";
    }else if ([model.orderstate integerValue] == 2) {
        self.cancelBtn.hidden = NO;
        self.orderStatus.text = @"Order received";
    }else if ([model.orderstate integerValue] == 3) {
        self.cancelBtn.hidden = NO;
        self.orderStatus.text = @"Delivering";
    }else {
        self.cancelBtn.hidden = YES;
        self.orderStatus.text = @"Completed";
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)cancelBtnAction:(id)sender {
    
    if ([self.delelgate respondsToSelector:@selector(orderPageTableViewCell:andCancelModel:)]) {
        [self.delelgate orderPageTableViewCell:self andCancelModel:_model];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
