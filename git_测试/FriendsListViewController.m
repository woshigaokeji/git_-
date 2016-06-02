//
//  FriendsListViewController.m
//  git_测试
//
//  Created by 马红涛 on 16/5/19.
//  Copyright © 2016年 马红涛. All rights reserved.
//
#define SDColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]
#define Global_mainBackgroundColor SDColor(248, 248, 248, 1)
#define Global_tintColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]
#import "FriendsListViewController.h"
#import "ChineseToPinyin.h"
#import "NSString+pinyin.h"
#import "SearchTableViewController.h"
#import "MessagingViewController.h"
@interface FriendsListViewController ()<UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *sectionTitlesArray;  //分区数组
    NSMutableArray *model;              //初始数据源
}

@property(nonatomic,strong)SearchTableViewController *searchVc; //搜搜显示的VC

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UISearchController *searchController;

@property(nonatomic,strong)NSMutableArray *dataSource;  //排序后数据源

@property(nonatomic,strong)NSMutableArray *SearchDataSource;  //搜索得到的数据源
    
@end
@implementation FriendsListViewController

- (void)viewWillDisappear:(BOOL)animated {
    //在viewWillDisappear中要将UISearchController移除, 否则切换到下一个View中, 搜索框仍然会有短暂的存在.
    [super viewWillDisappear:animated];
    if (self.searchController.active) {
        self.searchController.active = NO;
        [self.searchController.searchBar removeFromSuperview];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"通讯录";
    
    model = [[NSMutableArray alloc] init];
    NSArray *nameArr = [NSArray arrayWithObjects:@"沈海亮",@"沈应好",@"爱军",@"阿姨",@"韩哥",@"韩红",@"哈哈",@"江江",@"莉莉",@"李红",@"无邪",@"钱虹",@"孙海",@"孙俪",@"邓超",@"马超",@"赵超",@"刘备",@"丈夫",@"吴超",@"吴涛",@"55", nil];
    for (int i = 0; i<nameArr.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:nameArr[i] forKey:@"nameKey"];
        [dic setObject:@"头像" forKey:@"headImgaeKey"];
        [model addObject:dic];
    }
    [self sortDataArray:model];

    [self tableView];
    [self searchController];
    
}
//数据源排序
-(void)sortDataArray:(NSMutableArray *)dataArray
{
    //建立索引的核心
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    //创建section数组 --  二维数组(首层section,次层row)
    NSUInteger numberOfSections = [[indexCollation sectionTitles] count];
    NSMutableArray *newSectionArray =  [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index<numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc]init]];
    }
    
    //名字分section(相同首字母存入section内)
    for (NSDictionary *dict in dataArray) {
        //getUserName是实现中文拼音检索的核心，见NameIndex类
        NSString *userName = [dict objectForKey:@"nameKey"];
        NSString *firstLetter = [ChineseToPinyin pinyinFromChineseString:userName];
        NSString *str = [firstLetter substringToIndex:1];
        NSInteger section = [indexCollation sectionForObject:str collationStringSelector:@selector(uppercaseString)];
        NSMutableArray *array = [newSectionArray objectAtIndex:section];
        [array addObject:dict];
        
    }
    
    //每个section内的数组排序
    for (int i = 0; i < [newSectionArray count]; i++) {
        NSArray *array = [[newSectionArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *dict1, NSDictionary *dict2) {
            NSString *userName1 = [dict1 objectForKey:@"nameKey"];
            NSString *userName2 = [dict2 objectForKey:@"nameKey"];
            NSString *firstLetter1 = [ChineseToPinyin pinyinFromChineseString:userName1];
            firstLetter1 = [[firstLetter1 substringToIndex:1] uppercaseString];
            
            NSString *firstLetter2 = [ChineseToPinyin pinyinFromChineseString:userName2];
            firstLetter2 = [[firstLetter2 substringToIndex:1] uppercaseString];
            
            return [firstLetter1 caseInsensitiveCompare:firstLetter2];
        }];
        
        NSMutableArray *indexArry = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dict in array) {
            NSMutableDictionary *dictMutable = [[NSMutableDictionary alloc] initWithDictionary:dict];
            [indexArry addObject:dictMutable];
        }
        [newSectionArray replaceObjectAtIndex:i withObject:indexArry];
    }
    
    
    NSMutableArray *temp = [NSMutableArray new];
    sectionTitlesArray = [NSMutableArray new];
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {
            [temp addObject:arr];
        } else {
            //保存section标题数组
            [sectionTitlesArray addObject:[indexCollation sectionTitles][idx]];
        }
    }];
    //剔除空的scetion
    [newSectionArray removeObjectsInArray:temp];
    //排序后的数据源
    self.dataSource = newSectionArray;
}
#pragma mark --懒加载--
- (NSMutableArray *)SearchDataSource {
    if (nil == _SearchDataSource) {
        _SearchDataSource = [[NSMutableArray alloc] init];
    }
    return _SearchDataSource;
}
- (NSMutableArray *)dataSource {
    if (nil == _dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UISearchController *)searchController {
    if (nil == _searchController) {
        //初始化搜索显示的控制器 --(数据加载于这个控制器的tableview上面)
        _searchVc = [[SearchTableViewController alloc] init];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:_searchVc];
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
        [_searchController.searchBar sizeToFit];
        //搜索时，背景变模糊
//        _searchController.obscuresBackgroundDuringPresentation = YES;
//        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.placeholder =  @"快速搜索";
//        _searchController.searchBar.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.95];
        
        
//        UISearchBar *bar = self.searchController.searchBar;
//        bar.barStyle = UIBarStyleDefault;
//        bar.translucent = YES;
//        bar.barTintColor = Global_mainBackgroundColor;
//        bar.tintColor = Global_tintColor;
//        UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
//        view.layer.borderColor = Global_mainBackgroundColor.CGColor;
//        view.layer.borderWidth = 1;
//        
//        bar.layer.borderColor = [UIColor redColor].CGColor;
//        
////        bar.showsBookmarkButton = YES;
//        [bar setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
//        bar.delegate = self;
//        CGRect rect = bar.frame;
//        rect.size.height = 44;
//        bar.frame = rect;
        
//        self.tableView.tableHeaderView = self.searchController.searchBar;
        self.tableView.tableHeaderView = _searchController.searchBar;
//        self.tableView.rowHeight = [SDContactsTableViewCell fixedHeight];
        self.tableView.sectionIndexColor = [UIColor lightGrayColor];
        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
//        [self genDataWithCount:30];
    }
    
    return _searchController;
}

#pragma mark -
#pragma mark - searchController delegate --
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (self.SearchDataSource.count > 0) {
        [self.SearchDataSource removeAllObjects];
    }
    NSString *key = searchController.searchBar.text.lowercaseString;
    NSMutableArray *tempArr = [NSMutableArray array];
    
    // NSLog(@"key = %@",key);
    
    if (![key isEqualToString:@""] && ![key isEqual:[NSNull null]] && key != nil) {
        
        [model enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSMutableDictionary *dic = model[idx];
            
            //担心框架有时候会误转，再次都设置转为小写
            //名字 例如:小胡
            NSString *str = dic[@"nameKey"];
            NSString *name = str.lowercaseString;
            //全拼 例如:xiaohu
            NSString *nameFireLetter = [ChineseToPinyin pinyinFromChineseString:name].lowercaseString;
            //名字首字母 例如:xl
            NSString *namePinyin = [name transformToPinyinFirstLetter].lowercaseString;
            
            NSRange rang1 = [name rangeOfString:key];
            if (rang1.length>0) { ///比-比
                //中文名字存在搜索关键字
                [tempArr addObject:dic];
            }else{
                
                if ([nameFireLetter containsString:key]) { //bn - b
                    //全拼包含搜索关键字
                    [tempArr addObject:dic];
                    
                }else{  //ershou
                    if ([nameFireLetter containsString:[key substringToIndex:1]]) {
                        
                        if ([namePinyin containsString:key] ) {
                            [tempArr addObject:dic];
                        }
                    }
                }
            }
        }];
        
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![self.SearchDataSource containsObject:tempArr[idx]]) {
                
                [self.SearchDataSource addObject:tempArr[idx]];
            }
        }];
        
        _searchVc.dataArray = self.SearchDataSource;
    }
    [self.tableView reloadData];
}
#pragma mark --tableViewDelegate --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    if (self.searchController.active) {
//        return 1;
//    }
    return sectionTitlesArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *arr = _dataSource[section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSMutableDictionary *dic = _dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = dic[@"nameKey"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dic = _dataSource[indexPath.section][indexPath.row];
    MessagingViewController *messagingVC = [[MessagingViewController alloc] init];
    messagingVC.hidesBottomBarWhenPushed = YES;
    messagingVC.USerName = dic[@"nameKey"];
    [self.navigationController pushViewController:messagingVC animated:YES];
}
//添加section标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!self.searchController.active) {
        return sectionTitlesArray[section];
    }
    return @"";
    
}
//添加索引列
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView

{
    if (self.searchController.active)
    {
        return nil;
    }
    return sectionTitlesArray;
}
//索引列点击事件

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index

{
    NSLog(@"===%@  ===%ld",title,(long)index);
    
    //点击索引，列表跳转到对应索引的行
    
    return index;
    
}

@end
