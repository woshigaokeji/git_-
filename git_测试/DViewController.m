//
//  DViewController.m
//  git_测试
//
//  Created by 马红涛 on 16/5/9.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "DViewController.h"
#import "DTableViewCell.h"
#import "TransactionRecordsModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "KJMenuView.h"
@interface DViewController ()<UITableViewDataSource,UITableViewDelegate,SelectBtnDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)KJMenuView *menu;
@end

@implementation DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"交易记录";
    [self dataSource];
    [self tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    
}
- (void)rightAction:(UIBarButtonItem *)sender {
    
    [self menu];
    if (_menu.hidden) {
        [_menu showView];
    }else {
        [_menu hidView];
    }
}
- (KJMenuView *)menu {
    NSArray *titleArr = @[@"交易状态:",@"交易类型:"];
    NSArray *text1 = @[@"不限",@"进行中",@"处理成功",@"处理失败"];
    NSArray *text2 = @[@"不限",@"申购",@"定投",@"赎回",@"撤单",];
    NSArray *textArr = [NSArray arrayWithObjects:text1,text2, nil];
    if (nil == _menu) {
        _menu = [[KJMenuView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) TitleArr:titleArr TextArr:textArr titleCount:titleArr.count];
        _menu.delegate = self;
        [self.view addSubview:_menu];
    }
    return _menu;
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
- (NSMutableArray *)dataSource {
    if (nil == _dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"华南MSCI中国A股",@"stock",@"2016年4月12日 13:22:03",@"date",@"1",@"transactionType",@"100.00元",@"money",@"预计 04-28日确认",@"confirmDate",@"1",@"transactionStatus",nil];
//        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"订单确认",@"text",@"预计2016年4月12日订单确认",@"date",@"0",@"type",@"2",@"index",nil];
//        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"份额到账",@"text",@"预计2016年4月12日14:30所有基金份额到账",@"date",@"0",@"type",@"3",@"index",nil];
//        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"(请耐心等待哟,马上就到账了~_~)",@"text",@"",@"date",@"0",@"type",@"4",@"index",nil];
        TransactionRecordsModel *model = [TransactionRecordsModel OrderWithDic:dic];
        TransactionRecordsModel *model1 = [TransactionRecordsModel OrderWithDic:dic];
        TransactionRecordsModel *model2 = [TransactionRecordsModel OrderWithDic:dic];
        TransactionRecordsModel *model3 = [TransactionRecordsModel OrderWithDic:dic];
//        TransactionRecordsModel *model1 = [OrderModel OrderWithDic:dic1];
//        TransactionRecordsModel *model2 = [OrderModel OrderWithDic:dic2];
//        TransactionRecordsModel *model3 = [OrderModel OrderWithDic:dic3];
        [_dataSource addObject:model];
        [_dataSource addObject:model1];
        [_dataSource addObject:model2];
        [_dataSource addObject:model3];

    }
    return _dataSource;
}
#pragma mark -
#pragma mark --tableViewDelegate--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"cell";
    DTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[DTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    cell.model = _dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionRecordsModel *model = self.dataSource[indexPath.row];
    CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[DTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    
    return height;
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

#pragma marl --SelectBtnDelegate--
- (void)selectBtn:(NSMutableArray *)SelectRow {
    NSLog(@"selectRow = %@",SelectRow);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
