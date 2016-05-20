//
//  SearchTableViewController.m
//  git_测试
//
//  Created by 马红涛 on 16/5/20.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "SearchTableViewController.h"

@implementation SearchTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
}
- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    NSMutableDictionary *dic = _dataArray[indexPath.row];
    cell.textLabel.text = dic[@"nameKey"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"哈哈,你点击了好友！见证奇迹的时候来了!当当当当!好友界面出来啦!");
}

@end
