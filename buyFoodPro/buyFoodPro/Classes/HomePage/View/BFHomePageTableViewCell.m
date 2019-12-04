//
//  BFHomePageTableViewCell.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFHomePageTableViewCell.h"

@interface BFHomePageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *foodDesc;
@property (weak, nonatomic) IBOutlet UILabel *foodForm;
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;

@end

@implementation BFHomePageTableViewCell

- (void)setModel:(BFFoodModel *)model {
    _model = model;
    
    self.foodName.text = model.goodname;
    self.foodDesc.text = model.extend3;
    self.foodForm.text = [NSString stringWithFormat:@"by:%@",model.extend4];
    NSString *url = @"https://maochong.oss-cn-hangzhou.aliyuncs.com/";
    [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,model.goodimage]]];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
