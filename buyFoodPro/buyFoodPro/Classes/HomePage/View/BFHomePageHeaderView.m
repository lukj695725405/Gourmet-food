//
//  BFHomePageHeaderView.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/13.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFHomePageHeaderView.h"

@implementation BFHomePageHeaderView
    
+ (instancetype)homePageHeaderView {
    
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
