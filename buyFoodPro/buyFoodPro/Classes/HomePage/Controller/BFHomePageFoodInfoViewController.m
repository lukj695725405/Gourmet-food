//
//  BFHomePageFoodInfoViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFHomePageFoodInfoViewController.h"
#import "BFHomePagePlaceTheOrderViewController.h"
#import "BFIngredientsViewController.h"
@interface BFHomePageFoodInfoViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *foodImageH;
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *foodextend4;
@property (weak, nonatomic) IBOutlet UILabel *preparation;
@property (weak, nonatomic) IBOutlet UILabel *cook;
@property (weak, nonatomic) IBOutlet UILabel *readyIn;
@property (weak, nonatomic) IBOutlet UILabel *foodPrice;
@property (weak, nonatomic) IBOutlet UILabel *descrip;
@end

@implementation BFHomePageFoodInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)setupUI {
    
    self.navigationItem.title = @"Food details";
    
    NSString *url = @"https://maochong.oss-cn-hangzhou.aliyuncs.com/";
    UIImage *image = [UIImage imageWithData:[NSData dataWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,_model.goodimage]]]]];
    
    self.foodImageH.constant = image.size.height / image.size.width * ScreenW;
    self.foodImageView.image = image;
    self.foodextend4.text = [NSString stringWithFormat:@"By:%@",_model.extend4];
    
    NSArray *array = [_model.extend2 componentsSeparatedByString:@"￥"];
    self.preparation.text = array[0];
    self.cook.text = array[1];
    self.readyIn.text = array[2];
    self.descrip.text = _model.extend3;
    self.foodPrice.text = [NSString stringWithFormat:@"¥ %@",_model.goodprice];
}


- (IBAction)ingredientsBtnAction:(id)sender {
    BFIngredientsViewController *ingredientsVc = [[BFIngredientsViewController alloc] init];
    ingredientsVc.ingredientsStr = _model.gooddesc;
    ingredientsVc.titleName = _model.goodname;
    ingredientsVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ingredientsVc animated:YES];
}

- (IBAction)directionsBtnAction:(id)sender {
    BFIngredientsViewController *ingredientsVc = [[BFIngredientsViewController alloc] init];
    ingredientsVc.ingredientsStr = _model.goodcontent;
    ingredientsVc.titleName = _model.goodname;
    ingredientsVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ingredientsVc animated:YES];
}

- (IBAction)placeTheOrderBtnAction:(id)sender {
    
    BFHomePagePlaceTheOrderViewController *placeOrderVc = [[BFHomePagePlaceTheOrderViewController alloc] init];
    placeOrderVc.model = _model;
    placeOrderVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:placeOrderVc animated:YES];
    
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
