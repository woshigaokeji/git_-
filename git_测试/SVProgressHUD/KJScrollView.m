//
//  KJScrollView.m
//  git_测试
//
//  Created by 马红涛 on 16/4/14.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "KJScrollView.h"
#define IMAGEVIEW_COUNT 3
#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
@interface KJScrollView ()<UIScrollViewDelegate>

//滚动视图
@property(nonatomic,retain)UIScrollView *scrollView;
//左图片
@property(nonatomic,retain)UIImageView *leftImageView;
//中间图片
@property(nonatomic,retain)UIImageView *centerImageView;
//右边图片
@property(nonatomic,retain)UIImageView *rightImageView;
//页面控制器
@property(nonatomic,retain)UIPageControl *pageControl;
//图片的标题
@property(nonatomic,retain)UILabel *label;
@property(nonatomic,retain)NSMutableArray *imageArr;//图片数据
@property(nonatomic,assign)NSInteger currentImageIndex;//当前图片下标
@property(nonatomic,assign)NSInteger imageCount;//图片总数

@end
@implementation KJScrollView

- (id)initWithFrame:(CGRect)frame ImageArr:(NSMutableArray *)imageArr {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArr = imageArr;
        self.imageCount = imageArr.count;
        [self createScrollView];
    }
    
    return self;
}

- (void)createScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.scrollView.delegate = self;
    //设置contentSize
    self.scrollView.contentSize = CGSizeMake(IMAGEVIEW_COUNT*CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    //设置当前显示的位置为中间图片
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.frame), 0);
    //设置分页
    self.scrollView.pagingEnabled = YES;
    //去掉滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
#pragma mark 添加图片三个控件
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self.scrollView addSubview:_leftImageView];
    self.centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    [self.scrollView addSubview:_centerImageView];
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2 * CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    [self.scrollView addSubview:_rightImageView];
#pragma mark 添加分页控件
    self.pageControl = [[UIPageControl alloc]init];
    //注意此方法可以根据页数返回UIPageControl合适的大小
    CGSize size = [self.pageControl sizeForNumberOfPages:self.imageCount];
    self.pageControl.bounds = CGRectMake(0, 0, size.width, size.height - 20);
    //设置默认颜色,选中为白色
//    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    //默认颜色是白色,选中颜色设置
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    self.pageControl.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) - 20);
    //设置总页数
    self.pageControl.numberOfPages = self.imageCount;
    
    [self addSubview:_pageControl];
#pragma mark 添加信息描述控件
//    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.frame), 30)];
//    self.label.textAlignment = NSTextAlignmentCenter;
//    self.label.textColor = [UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
//    
//    [self.view addSubview:_label];
    
    
#pragma mark 设置默认显示图片
    //加载默认图片
    self.leftImageView.image = [UIImage imageNamed:_imageArr[_imageCount-1]];
    self.centerImageView.image = [UIImage imageNamed:_imageArr[0]];
    self.rightImageView.image = [UIImage imageNamed:_imageArr[1]];
    self.currentImageIndex = 0;
    //设置当前页
    self.pageControl.currentPage = self.currentImageIndex;
    
}

#pragma mark 滚动停止事件
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //重新加载图片
    [self reloadImage];
    //移动到中间
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.frame), 0);
    //设置分页
    self.pageControl.currentPage = self.currentImageIndex;
    //设置描述
//    NSString *imageName = [NSString stringWithFormat:@"%ld.JPG",_currentImageIndex];
//    self.label.text = self.imageData[imageName];
}

#pragma mark 重新加载图片
-(void)reloadImage{
    NSInteger leftImageIndex,rightImageIndex;
    CGPoint offset = [self.scrollView contentOffset];
    if (offset.x > CGRectGetWidth(self.frame)) { //向右滑动
        self.currentImageIndex = (self.currentImageIndex + 1) % self.imageCount;
    }else if(offset.x < CGRectGetWidth(self.frame)){ //向左滑动
        self.currentImageIndex = (self.currentImageIndex + self.imageCount - 1) % self.imageCount;
    }
    
    self.centerImageView.image = [UIImage imageNamed:_imageArr[self.currentImageIndex]];
    
    //重新设置左右图片
    leftImageIndex = (self.currentImageIndex + self.imageCount - 1) % self.imageCount;
    rightImageIndex = (self.currentImageIndex + 1) % self.imageCount;
    self.leftImageView.image = [UIImage imageNamed:_imageArr[leftImageIndex]];
    self.rightImageView.image = [UIImage imageNamed:_imageArr[rightImageIndex]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
