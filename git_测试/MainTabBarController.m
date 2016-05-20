//
//  MainTabBarController.m
//  git_测试
//
//  Created by 马红涛 on 16/4/13.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "MainTabBarController.h"
#import "MyTabBarBtn.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
@interface MainTabBarController () {
    MyTabBarBtn *_btnLeft;
    MyTabBarBtn *_btnRight;
    MyTabBarBtn *_btncenter;
    MyTabBarBtn *_btnFour;
    MyTabBarBtn *_btnFive;
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 后添加按钮
    CGFloat width = SCREEN_WIDTH/5;
    UITabBar *tabBar = self.tabBar;
    tabBar.barTintColor = [UIColor clearColor];
    tabBar.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    _btnLeft = [[MyTabBarBtn alloc] init];
    _btnLeft.frame = CGRectMake(0, 0, width, tabBar.frame.size.height);
    [_btnLeft setImage:[[UIImage imageNamed:@"friendsRecommentIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btnLeft setImage:[[UIImage imageNamed:@"friendsRecommentIcon-click"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btnLeft setTitle:@"今日回访" forState:UIControlStateNormal];
    _btnLeft.titleLabel.font = [UIFont systemFontOfSize:10];
    [_btnLeft setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnNorBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnSelBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btnLeft addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:_btnLeft];
    
    _btnRight = [[MyTabBarBtn alloc] init];
    _btnRight.frame = CGRectMake(width, 0, width, tabBar.frame.size.height);
    [_btnRight setImage:[[UIImage imageNamed:@"nav_coin_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btnRight setImage:[[UIImage imageNamed:@"nav_coin_icon_click"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btnRight setTitle:@"我的客户" forState:UIControlStateNormal];
    _btnRight.titleLabel.font = [UIFont systemFontOfSize:10];
    [_btnRight setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btnRight setBackgroundImage:[[UIImage imageNamed:@"btnNorBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btnRight setBackgroundImage:[[UIImage imageNamed:@"btnSelBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btnRight addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:_btnRight];
    
    _btncenter = [[MyTabBarBtn alloc] init];
    _btncenter.frame = CGRectMake(width*2, 0, width, tabBar.frame.size.height);
    [_btncenter setImage:[[UIImage imageNamed:@"nav_coin_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btncenter setImage:[[UIImage imageNamed:@"nav_coin_icon_click"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btncenter setTitle:@"啦啦啦😄" forState:UIControlStateNormal];
    _btncenter.titleLabel.font = [UIFont systemFontOfSize:10];
    [_btncenter setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btncenter setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btncenter setBackgroundImage:[[UIImage imageNamed:@"btnNorBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btncenter setBackgroundImage:[[UIImage imageNamed:@"btnSelBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btncenter addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:_btncenter];
    
    _btnFour = [[MyTabBarBtn alloc] init];
    _btnFour.frame = CGRectMake(width*3, 0, width, tabBar.frame.size.height);
    [_btnFour setImage:[[UIImage imageNamed:@"nav_coin_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btnFour setImage:[[UIImage imageNamed:@"nav_coin_icon_click"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btnFour setTitle:@"交易记录" forState:UIControlStateNormal];
    _btnFour.titleLabel.font = [UIFont systemFontOfSize:10];
    [_btnFour setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btnFour setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btnFour setBackgroundImage:[[UIImage imageNamed:@"btnNorBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btnFour setBackgroundImage:[[UIImage imageNamed:@"btnSelBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btnFour addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:_btnFour];
    
    _btnFive = [[MyTabBarBtn alloc] init];
    _btnFive.frame = CGRectMake(width*4, 0, SCREEN_WIDTH/4, tabBar.frame.size.height);
    [_btnFive setImage:[[UIImage imageNamed:@"nav_coin_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btnFive setImage:[[UIImage imageNamed:@"nav_coin_icon_click"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btnFive setTitle:@"好友列表" forState:UIControlStateNormal];
    _btnFive.titleLabel.font = [UIFont systemFontOfSize:10];
    [_btnFive setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btnFive setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btnFive setBackgroundImage:[[UIImage imageNamed:@"btnNorBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btnFive setBackgroundImage:[[UIImage imageNamed:@"btnSelBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btnFive addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:_btnFive];
    
    // 默认显示今日回访
    _btnLeft.selected = YES;
    
}
- (void)btnClicked:(UIView *)sender {
    
    if ([sender isEqual:_btnLeft]) {
        if (!_btnLeft.selected) {
            self.selectedIndex = 0;
            _btnRight.selected = NO;
            _btnLeft.selected = YES;
            _btncenter.selected = NO;
            _btnFour.selected = NO;
            _btnFive.selected = NO;
        }
        
    } else if ([sender isEqual:_btnRight]) {
        self.selectedIndex = 1;
        _btnLeft.selected = NO;
        _btnRight.selected = YES;
        _btncenter.selected = NO;
        _btnFour.selected = NO;
        _btnFive.selected = NO;
    }else if ([sender isEqual:_btncenter]) {
        self.selectedIndex = 2;
        _btnLeft.selected = NO;
        _btnRight.selected = NO;
        _btncenter.selected = YES;
        _btnFour.selected = NO;
        _btnFive.selected = NO;
    }else if ([sender isEqual:_btnFour]) {
        self.selectedIndex = 3;
        _btnLeft.selected = NO;
        _btnRight.selected = NO;
        _btncenter.selected = NO;
        _btnFour.selected = YES;
        _btnFive.selected = NO;
    }else {
        self.selectedIndex = 4;
        _btnLeft.selected = NO;
        _btnRight.selected = NO;
        _btncenter.selected = NO;
        _btnFour.selected = NO;
        _btnFive.selected = YES;
    }
    
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
