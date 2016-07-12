//
//  SliderViewController.m
//  git_测试
//
//  Created by 马红涛 on 16/6/7.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "SliderViewController.h"
#import "UIScrollView+VGParallaxHeader.h"
@interface SliderViewController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UILabel *bank;
@property(nonatomic,strong)UISlider *slider;
@end
@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"智能理财";
    self.navigationController.navigationBar.translucent = NO;
    [self dataSource];
    [self tableView];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
}

- (NSMutableArray *)dataSource {
    if (nil == _dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
       
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
        
        CGFloat height = 200;
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), height)];
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavigationBar"]];
        
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), height)];
        backView.userInteractionEnabled = YES;
        backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavigationBar"]];
        
        UILabel *Money = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 40)];
        Money.text = @"您的风险等级为";
        Money.font = [UIFont systemFontOfSize:12];
        Money.textAlignment = NSTextAlignmentCenter;
        Money.textColor = [UIColor whiteColor];
        [backView addSubview:Money];
        
        _bank = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(Money.frame), CGRectGetWidth(self.view.frame), 20)];
        _bank.text = @"7";
        _bank.font = [UIFont systemFontOfSize:25];
        _bank.textAlignment = NSTextAlignmentCenter;
        _bank.textColor = [UIColor whiteColor];
        [backView addSubview:_bank];
        
        //滚动条
        _slider = [[UISlider alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_bank.frame)+10, CGRectGetWidth(self.view.frame) - 20,20)];
        _slider.minimumValue = 1;  //设置最小值
        _slider.maximumValue = 10; //设置最大值
        _slider.value = 1;  //设置默认值
        //    slider.continuous = YES;  //设置滑块值是否连续变化(默认为YES)
        _slider.minimumTrackTintColor = [UIColor clearColor]; //设置滑块左边（小于部分）线条的颜色
        _slider.maximumTrackTintColor = [UIColor clearColor]; //设置滑块右边（大于部分）线条的颜色
        //设置滑块的图片：
        [_slider setThumbImage:[UIImage imageNamed:@"等级调整按钮"] forState:UIControlStateNormal];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(_slider.frame), 10)];
        image.image = [UIImage imageNamed:@"等级"];
        [_slider addSubview:image];
        //添加触发事件
        [_slider addTarget:self action:@selector(log:) forControlEvents:UIControlEventValueChanged];
        
        [backView addSubview:_slider];
        
        //最小最大值label
        UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_slider.frame) + 5, CGRectGetMaxY(_slider.frame)+5, 40, 20)];
        minLabel.text = [NSString stringWithFormat:@"%.0f",_slider.minimumValue];
        minLabel.textColor = [UIColor whiteColor];
        [backView addSubview:minLabel];
        
        UILabel *maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_slider.frame) - 45, CGRectGetMinY(minLabel.frame), CGRectGetWidth(minLabel.frame), CGRectGetHeight(minLabel.frame))];
        maxLabel.text = [NSString stringWithFormat:@"%.0f",_slider.maximumValue];
        maxLabel.textColor = [UIColor whiteColor];
        maxLabel.textAlignment = NSTextAlignmentRight;
        [backView addSubview:maxLabel];
        
        //扇形图
        UIView *OrderView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(backView.frame) - 60, CGRectGetWidth(backView.frame), 60)];
        OrderView.backgroundColor = [UIColor lightGrayColor];
        OrderView.alpha = 0.5;
        [backView addSubview:OrderView];
        
        UIView *SectorView = [self SectorViewWithTitle:@"年化收益" text:@"7.86%" Type:3 rect:CGRectMake(20, 0, 60, 60)];
        [OrderView addSubview:SectorView];
        
        UIView *SectorView1 = [self SectorViewWithTitle:@"稳健性" text:@"极稳健" Type:3 rect:CGRectMake(CGRectGetMidX(OrderView.frame) - 30, 0, 60, 60)];
        [OrderView addSubview:SectorView1];
        
        UIView *SectorView2 = [self SectorViewWithTitle:@"流动性" text:@"极高" Type:3 rect:CGRectMake(CGRectGetMaxX(OrderView.frame) - 80, 0, 60, 60)];
        [OrderView addSubview:SectorView2];
        
        //添加头部视图
        [_tableView setParallaxHeaderView:view mode:VGParallaxHeaderModeFill height:height];
        
        _tableView.parallaxHeader.stickyViewPosition = VGParallaxHeaderStickyViewPositionBottom;
        [_tableView.parallaxHeader setStickyView:backView withHeight:height];
        
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}
/**
 *  slider滑动响应方法
 *
 *  @param sender slider
 */
- (void)log:(UISlider *)sender {
    NSLog(@"float = %f",sender.value);
}

- (UIView *)SectorViewWithTitle:(NSString *)title
                           text:(NSString *)text
                           Type:(NSInteger)type
                           rect:(CGRect)rect{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(titleLabel.frame), 20)];
    image.image = [UIImage imageNamed:@"th"];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(image.frame), CGRectGetMaxY(image.frame), CGRectGetWidth(titleLabel.frame), 20)];
    textLabel.text = text;
    textLabel.font = [UIFont systemFontOfSize:12];
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:titleLabel];
    [view addSubview:image];
    [view addSubview:textLabel];
    
    switch (type) {
        case 0:
        {
            image.image = [UIImage imageNamed:@"one"];
            break;
        }
        case 1:
        {
            image.image = [UIImage imageNamed:@"two"];
            break;
        }
        case 2:
        {
            image.image = [UIImage imageNamed:@"th"];
            break;
        }
        case 3:
        {
            image.image = [UIImage imageNamed:@"fo"];
            break;
        }
        case 4:
        {
            image.image = [UIImage imageNamed:@"five"];
            break;
        }
            
            
        default:
            break;
    }
    
    
    return view;
}

#pragma mark -
#pragma mark --tableviewDelegate--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //关键代码 --适配滑动的位置差
    [_tableView shouldPositionParallaxHeader];
}

@end
