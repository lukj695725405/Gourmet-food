//
//  BFAddressTableViewCell.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFAddressTableViewCell.h"

@interface BFAddressTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UILabel *nameText;
@property (weak, nonatomic) IBOutlet UILabel *addressText;

@end

@implementation BFAddressTableViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}
- (void)setupUI{
    
    self.nameText.text = NSLocalizedString(_nameText.text, nil);
    self.addressText.text = NSLocalizedString(_addressText.text, nil);
    
}

- (void)setModel:(BFAddressModel *)model {
    _model = model;
    self.nameLb.text = model.name;
    self.addressLb.text = [NSString stringWithFormat:@"%@%@",model.city,model.address];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
