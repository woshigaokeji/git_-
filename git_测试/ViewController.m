//
//  ViewController.m
//  git_测试
//
//  Created by 马红涛 on 16/3/21.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"haha");
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    NSLog(@"我添加了一个新的分支!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
