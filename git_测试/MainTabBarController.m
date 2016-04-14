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
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 后添加按钮
    
    UITabBar *tabBar = self.tabBar;
    tabBar.barTintColor = [UIColor clearColor];
    tabBar.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    _btnLeft = [[MyTabBarBtn alloc] init];
    _btnLeft.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, tabBar.frame.size.height);
    [_btnLeft setImage:[[UIImage imageNamed:@"friendsRecommentIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btnLeft setImage:[[UIImage imageNamed:@"friendsRecommentIcon-click"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btnLeft setTitle:@"今日回访" forState:UIControlStateNormal];
    [_btnLeft setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnNorBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btnLeft setBackgroundImage:[[UIImage imageNamed:@"btnSelBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btnLeft addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:_btnLeft];
    
    _btnRight = [[MyTabBarBtn alloc] init];
    _btnRight.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, tabBar.frame.size.height);
    [_btnRight setImage:[[UIImage imageNamed:@"nav_coin_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btnRight setImage:[[UIImage imageNamed:@"nav_coin_icon_click"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btnRight setTitle:@"我的客户" forState:UIControlStateNormal];
    [_btnRight setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_btnRight setBackgroundImage:[[UIImage imageNamed:@"btnNorBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_btnRight setBackgroundImage:[[UIImage imageNamed:@"btnSelBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [_btnRight addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:_btnRight];
    
    // 默认显示今日回访
    _btnLeft.selected = YES;
    
}
- (void)btnClicked:(UIView *)sender {
    
    if ([sender isEqual:_btnLeft]) {
        if (!_btnLeft.selected) {
            self.selectedIndex = 0;
            _btnRight.selected = NO;
            _btnLeft.selected = YES;
        }
        
    } else if ([sender isEqual:_btnRight]) {
        self.selectedIndex = 1;
        _btnLeft.selected = NO;
        _btnRight.selected = YES;
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
