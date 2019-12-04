//
//  BFAddressListViewController.m
//  buyFoodPro
//
//  Created by Lukj on 2019/11/15.
//  Copyright © 2019 buyFoodPro. All rights reserved.
//

#import "BFAddressListViewController.h"
#import "BFUserModel.h"

#import "BFAddressTableViewCell.h"
#import "BFAddAddressViewController.h"
@interface BFAddressListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic,strong)UISearchBar * searchBar;
@property (nonatomic, strong)UITextField *searchField;
//@property (nonatomic, strong)NSArray *peasantArr;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *notPeasantView;

@property (nonatomic, strong) NSArray * tableData;

@property (nonatomic, strong) NSMutableArray * resultData;

@property (nonatomic, strong) NSArray * tableIndexData;

@property (nonatomic, strong) NSMutableArray * resultIndexData;

@property (nonatomic, assign) BOOL  searchActive;

@property (nonatomic, strong)BFUserModel *userModel;

@end
static NSString *cellid = @"AddressListViewController";
@implementation BFAddressListViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getAddressListData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}


- (void)setupUI {
    
    self.title = @"Home address";
    [self setupTableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView*titleView = [[UIView alloc]initWithFrame:CGRectMake(0,0,ScreenW - 150,30)];
    [titleView setBackgroundColor:[UIColor clearColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Add address" style:UIBarButtonItemStylePlain target:self action:@selector(addAdress:)];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 180, 30)];
    self.searchBar.placeholder = @"Search name";
    self.searchBar.layer.cornerRadius = 15;
    self.searchBar.layer.masksToBounds = YES;
    self.searchBar.delegate = self;
    // 修改cancel
    self.searchBar.showsCancelButton = NO;
    self.searchBar.barStyle = UIBarStyleDefault;
    self.searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    //没有背影，透明样式
    //    self.searchBar.delegate = self;
    // 修改cancel
    self.searchBar.showsSearchResultsButton = NO;
    //5. 设置搜索Icon
    //    [self.searchBar setImage:[UIImage imageNamed:@"Search_Icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    /*这段代码有个特别的地方就是通过KVC获得到UISearchBar的私有变量   searchField（类型为UITextField），设置SearchBar的边框颜色和圆角实际上也就变成了设置searchField的边框颜色和圆角，你可以试试直接设置SearchBar.layer.borderColor和cornerRadius，会发现这样做是有问题的。*/
    //一下代码为修改placeholder字体的颜色和大小
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    //2. 设置圆角和边框颜色
    if(searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];    //
        //        searchField.layer.borderColor = [UIColor blueColor].CGColor;
        
        searchField.layer.borderWidth = 0;
        
        searchField.layer.cornerRadius = 10.0f;
        
        searchField.layer.masksToBounds = YES;
        
        // 根据@"_placeholderLabel.textColor" 找到placeholder的字体颜色
        //        [searchField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        
    }
    // 输入文本颜色
    //    searchField.textColor= [UIColor whiteColor];
    searchField.font= [UIFont systemFontOfSize:15];
    // 默认文本大小
    //    [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    //只有编辑时出现出现那个叉叉
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [titleView addSubview:self.searchBar];
    self.searchField = searchField;
    
    [titleView addSubview:self.searchBar];
    
    self.navigationItem.titleView = titleView;
    
    // 暂无数据的时候显示
    UIView *notPeasantView = [[UIView alloc]init];
    notPeasantView.hidden = YES;
    [self.view addSubview:notPeasantView];
    [notPeasantView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(300);
    }];
    
    
    UIImageView *notPeasantImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Temporarily no data"]];
    [notPeasantView addSubview:notPeasantImageView];
    [notPeasantImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(notPeasantView);
        make.top.equalTo(notPeasantView);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //    [btn setBackgroundImage:[UIImage imageNamed:@"button_bg_glay"] forState:UIControlStateNormal];
    [btn setTitle:@"Add the address" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [notPeasantView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(notPeasantView);
        make.top.equalTo(notPeasantImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    //    [btn addTarget:self action:@selector(addPeasantBtn) forControlEvents:UIControlEventTouchUpInside];
    self.notPeasantView = notPeasantView;
    
}

- (void)setupTableView {
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:(UITableViewStylePlain)];
    table.dataSource = self;
    table.delegate = self;
    table.rowHeight = 64;
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [table registerNib:[UINib nibWithNibName:@"BFAddressTableViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    [self.view addSubview:table];
    self.tableView = table;
    // 设置foot 可以隐藏没有数据的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}


- (void)addAdress:(UIBarButtonItem *)sender {
    
    BFAddAddressViewController *addAdressVc = [[BFAddAddressViewController alloc] init];
    [self.navigationController pushViewController:addAdressVc animated:YES];
}


- (void)blackAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //加个多线程，否则数量量大的时候，有明显的卡顿现象
    //这里最好放在数据库里面再进行搜索，效率会更快一些
    if (searchText.length == 0){
        
        _searchActive = NO;
        [self.tableView reloadData];
        return;
    }
    _searchActive = YES;
    _resultData = [NSMutableArray array];
    _resultIndexData = [NSMutableArray array];
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        //遍历需要搜索的所有内容，其中self.dataArray为存放总数据的数组
        [self.tableData enumerateObjectsUsingBlock:^(NSMutableArray * obj, NSUInteger aIdx, BOOL * _Nonnull stop) {
            //刚进来 && 第一个数组不为空时 插入一个数组在第一个位置
            if (self.resultData.count == 0 || [[self.resultData lastObject] count] != 0){
                
                [self.resultData addObject:[NSMutableArray array]];
            }
            
            [obj enumerateObjectsUsingBlock:^(BFAddressModel * model, NSUInteger bIdx, BOOL * _Nonnull stop) {
                
                NSString *tempStr = model.name;
                //----------->把所有的搜索结果转成成拼音
                NSString *pinyin = [self transformToPinyin:tempStr isQuanPin:NO];
                
                if ([pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch].length > 0){
                    
                    //把搜索结果存放self.resultArray数组
                    [self.resultData.lastObject addObject:model];
                    if (self.resultIndexData == 0 || ![self.resultIndexData.lastObject isEqualToString:self.tableIndexData[aIdx]])
                    {
                        [self.resultIndexData addObject:self.tableIndexData[aIdx]];
                    }
                }
            }];
        }];
        //回到主线程
        if ([self.resultData.lastObject count] == 0){
            
            [self.resultData removeLastObject];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
}

#pragma mark - Scroll View Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _searchActive ? _resultData.count : _tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _searchActive ? [_resultData[section] count] : [_tableData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BFAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    BFAddressModel * model = _searchActive ? _resultData[indexPath.section][indexPath.row] : _tableData[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - tableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
    BFAddressModel *model = self.tableData[indexPath.section][indexPath.row];
    if (self.peasantModelBlock) {
        self.peasantModelBlock(model);
    }
    
    if (self.peasantModelBlock) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


//返回当用户触摸到某个索引标题时列表应该跳至的区域的索引。
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    //    [SVProgressHUD showImage:nil status:title];
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

//将汉字转为拼音 是否支持全拼可选
- (NSString *)transformToPinyin:(NSString *)aString isQuanPin:(BOOL)quanPin{
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    if (quanPin){
        
        int count = 0;
        for (int  i = 0; i < pinyinArray.count; i++){
            
            for(int i = 0; i < pinyinArray.count;i++){
                
                if (i == count) {
                    [allString appendString:@"#"];
                    //区分第几个字母
                }
                [allString appendFormat:@"%@",pinyinArray[i]];
            }
            [allString appendString:@","];
            count ++;
        }
    }
    
    NSMutableString *initialStr = [NSMutableString new];
    //拼音首字母
    for (NSString *s in pinyinArray){
        
        if (s.length > 0){
            
            [initialStr appendString:[s substringToIndex:1]];
        }
    }
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    return allString;
}

//将传进来的对象按通讯录那样分组排序，每个section中也排序  dataarray是中存储的是一组对象，selector是属性名
- (NSArray *)sringSectioncompositor:(NSArray *)dataArray withSelector:(SEL)selector isDeleEmptyArray:(BOOL)isDele{
    
    //    UILocalizedIndexedCollation是苹果贴心为开发者提供的排序工具，会自动根据不同地区生成索引标题
    UILocalizedIndexedCollation  *collation = [UILocalizedIndexedCollation currentCollation];
    
    NSMutableArray * indexArray = [NSMutableArray arrayWithArray:collation.sectionTitles];
    
    NSUInteger sectionNumber = indexArray.count;
    //建立每个section数组
    NSMutableArray * sectionArray = [NSMutableArray arrayWithCapacity:sectionNumber];
    for (int n = 0; n < sectionNumber; n++){
        
        NSMutableArray *subArray = [NSMutableArray array];
        [sectionArray addObject:subArray];
    }
    
    for (BFAddressModel *model in dataArray){
        //        根据SEL方法返回的字符串判断对象应该处于哪个分区
        NSInteger index = [collation sectionForObject:model collationStringSelector:selector];
        NSMutableArray *tempArray = sectionArray[index];
        [tempArray addObject:model];
    }
    for (NSMutableArray *tempArray in sectionArray){
        //        根据SEL方法返回的string对数组元素排序
        NSArray* sorArray = [collation sortedArrayFromArray:tempArray collationStringSelector:selector];
        [tempArray removeAllObjects];
        [tempArray addObjectsFromArray:sorArray];
    }
    
    //    是否删除空数组
    if (isDele){
        [sectionArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.count == 0)
            {
                [sectionArray removeObjectAtIndex:idx];
                [indexArray removeObjectAtIndex:idx];
            }
        }];
    }
    //返回第一个数组为table数据源  第二个数组为索引数组
    return @[sectionArray, indexArray];
}

- (void)getAddressListData {
    NSString *userid = [BFAccountManager getUserDefaultObject:@"userid"]?[BFAccountManager getUserDefaultObject:@"userid"]:@"";
    NSString *usetype = [BFAccountManager getUserDefaultObject:@"usetype"]?[BFAccountManager getUserDefaultObject:@"usetype"]:@"";
    NSDictionary *parameters = @{@"usetype":usetype,@"userid":userid};
    [JLNetWorking POST:@"/address/addressList" parameters:parameters httpSuccess:^(NSDictionary *dict) {
        self.tableData = [BFAddressModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        
        NSArray * tempArray = [self sringSectioncompositor:self.tableData withSelector:@selector(name)isDeleEmptyArray:YES];
        self.tableData = tempArray[0];
        self.tableIndexData = tempArray[1];
        
        
        [self.tableView reloadData];
    } httpFailed:^(NSString *error) {

    }];

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
