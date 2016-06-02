//
//  MessagingViewController.m
//  git_测试
//
//  Created by 马红涛 on 16/5/31.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "MessagingViewController.h"
#import "MessagingModel.h"
#import "MessagingCell.h"
@interface MessagingViewController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *DataSource;

@end
@implementation MessagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.USerName;
    
    [self tableView];
    [self DataSource];
    MessagingModel *model = [[MessagingModel alloc] initWithText:@"亲爱的,可以问你一个问题吗" time:@"2016-1-1 12:00:00" image:@"" messagingType:OtherType textType:textTyep headImage:@"friendsRecommentIcon-click"];
    MessagingModel *model1 = [[MessagingModel alloc] initWithText:@"好啊,好啊" time:@"5:10:11" image:@"" messagingType:UserType textType:textTyep headImage:@"friendsRecommentIcon-click"];
    MessagingModel *model2 = [[MessagingModel alloc] initWithText:@"你是我最好的朋友吗?" time:@"5:12:12" image:@"" messagingType:OtherType textType:textTyep headImage:@"friendsRecommentIcon-click"];
    MessagingModel *model3 = [[MessagingModel alloc] initWithText:@"是的呀,怎么了呀" time:@"5:12:50" image:@"" messagingType:UserType textType:textTyep headImage:@"friendsRecommentIcon-click"];
    MessagingModel *model4 = [[MessagingModel alloc] initWithText:@"那就好,我刚看了一篇文章,说狗是人类最好的朋友,所以我来确认一下,谢谢你肯定的回答" time:@"5:13:50" image:@"" messagingType:OtherType textType:textTyep headImage:@"friendsRecommentIcon-click"];
    MessagingModel *model5 = [[MessagingModel alloc] initWithText:@"" time:@"5:12:50" image:@"猫猫和狗" messagingType:UserType textType:ImageType headImage:@"friendsRecommentIcon-click"];
    MessagingModel *model6 = [[MessagingModel alloc] initWithText:@"我觉得这张图片最能说明问题了,我是狗,那么你就是猫咯" time:@"5:20:50" image:@"" messagingType:UserType textType:textTyep headImage:@"friendsRecommentIcon-click"];
    [self.DataSource addObject:model];
    [self.DataSource addObject:model1];
    [self.DataSource addObject:model2];
    [self.DataSource addObject:model3];
    [self.DataSource addObject:model4];
    [self.DataSource addObject:model5];
    [self.DataSource addObject:model6];
    [self.tableView reloadData];
    
}


#pragma mark--懒加载--
- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        //去掉分割线
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//        _tableView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}
- (NSMutableArray *)DataSource {
    if (nil == _DataSource) {
        _DataSource = [[NSMutableArray alloc ] init];
    }
    return _DataSource;
}



#pragma mark-
#pragma mark-------tableViewDelegate--------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _DataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"cell";
    MessagingCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[MessagingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _DataSource[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessagingModel *model = _DataSource[indexPath.row];
    return model.height + 5;
}


@end
