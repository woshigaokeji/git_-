//
//  CViewController.m
//  git_测试
//
//  Created by 马红涛 on 16/5/4.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "CViewController.h"
#import "UIScrollView+VGParallaxHeader.h"
#import "OrderModel.h"
#import "CTableViewCell.h"
@interface CViewController ()<UITableViewDelegate,UITableViewDataSource> {
    OrderModel *oldModel;
}

@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation CViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"XXXXX发展基金";
    self.navigationController.navigationBar.translucent = NO;
    [self dataSource];
    [self tableView];
}
- (NSMutableArray *)dataSource {
    if (nil == _dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"订单创建成功",@"text",@"2016年4月12日 13:22:03",@"date",@"1",@"type",@"1",@"index",nil];
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"订单确认",@"text",@"预计2016年4月12日订单确认",@"date",@"0",@"type",@"2",@"index",nil];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"份额到账",@"text",@"预计2016年4月12日14:30所有基金份额到账",@"date",@"0",@"type",@"3",@"index",nil];
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"(请耐心等待哟,马上就到账了~_~)",@"text",@"",@"date",@"0",@"type",@"4",@"index",nil];
        OrderModel *model = [OrderModel OrderWithDic:dic];
        OrderModel *model1 = [OrderModel OrderWithDic:dic1];
        OrderModel *model2 = [OrderModel OrderWithDic:dic2];
        OrderModel *model3 = [OrderModel OrderWithDic:dic3];
        [_dataSource addObject:model];
        [_dataSource addObject:model1];
        [_dataSource addObject:model2];
        [_dataSource addObject:model3];
    }
    return _dataSource;
}
- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 140)];
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavigationBar"]];

        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 140)];
        backView.userInteractionEnabled = YES;
        backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavigationBar"]];
        
        UILabel *Money = [[UILabel alloc] initWithFrame:CGRectMake(0, backView.center.y - 40, CGRectGetWidth(self.view.frame), 40)];
        Money.text = @"¥954.55";
        Money.textAlignment = NSTextAlignmentCenter;
        Money.textColor = [UIColor whiteColor];
        [backView addSubview:Money];
        
        UILabel *bank = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(Money.frame), CGRectGetWidth(self.view.frame), 20)];
        bank.text = @"招商银行 尾号1018";
        bank.textAlignment = NSTextAlignmentCenter;
        bank.textColor = [UIColor whiteColor];
        [backView addSubview:bank];
        
        UIView *OrderView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(backView.frame) - 30, CGRectGetWidth(backView.frame), 30)];
        OrderView.backgroundColor = [UIColor lightGrayColor];
        OrderView.alpha = 0.5;
        [backView addSubview:OrderView];
        
        UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 40, 20)];
        text.text = @"申购";
        text.textColor = [UIColor whiteColor];
        [OrderView addSubview:text];
        
        UILabel *orderNumber = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(text.frame), CGRectGetMinY(text.frame), CGRectGetWidth(OrderView.frame) - CGRectGetMaxX(text.frame), CGRectGetHeight(text.frame))];
        orderNumber.text = @"订单号:1297335976212358";
        orderNumber.textAlignment = NSTextAlignmentRight;
        orderNumber.textColor = [UIColor whiteColor];
        [OrderView addSubview:orderNumber];
        
        //添加头部视图
        [_tableView setParallaxHeaderView:view mode:VGParallaxHeaderModeFill height:140];
        
        _tableView.parallaxHeader.stickyViewPosition = VGParallaxHeaderStickyViewPositionBottom;
        [_tableView.parallaxHeader setStickyView:backView withHeight:140];
        
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}
#pragma mark -
#pragma mark --tableviewDelegate--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"cell";
    CTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[CTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    OrderModel *model = _dataSource[indexPath.row];
    //走model的set方法，获取上划线和下划线view
    cell.model = model;
    if (indexPath.row) {
        if (model.type == 1) {
            //判断当前订单状态
            switch (oldModel.type) {
                    //判断上一个步骤的状态设置时间轴
                    //设置下划线颜色
                case 0:
                {
                    UIView *lineView = oldModel.lastLineView;
                    lineView.backgroundColor = [UIColor redColor];
                    break;
                }
                case 1:
                {
                    UIView *lineView = oldModel.lastLineView;
                    lineView.backgroundColor = [UIColor greenColor];
                    break;
                }
                case 2:
                {
                    UIView *lineView = oldModel.lastLineView;
                    lineView.backgroundColor = [UIColor lightGrayColor];
                    break;
                }
                    
                default:
                    break;
            }

        }else if (model.type == 0) {
            UIView *lineView = oldModel.lastLineView;
            lineView.backgroundColor = [UIColor redColor];
        }
    }else {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(20,-5 , 20, 20)];
        image.image = [UIImage imageNamed:@"交易详情"];
        [cell.contentView addSubview:image];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    oldModel = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderModel *model = _dataSource[indexPath.row];
    return model.cellHeight;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //关键代码 --适配滑动的位置差
    [_tableView shouldPositionParallaxHeader];
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
