//
//  AViewController.m
//  git_测试
//
//  Created by 马红涛 on 16/4/13.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "AViewController.h"
#import "ACollectionViewCell.h"
#import "KJScrollView.h"
#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height-StatusBarHeight)

@interface AViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIView *_headView;
    NSMutableArray *dataource; //*<数据源*/
    NSMutableArray *imageDataSource; //*<图片数据源*/
}
@property(nonatomic,strong)KJScrollView *ScrollView;
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation AViewController
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"今日回访";
    [self ScrollView];
    [self collectionView];
    
}

- (KJScrollView *)ScrollView {
    if (nil == _ScrollView) {
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"guid1_375",@"test",@"guid4_375",@"guid2_375", nil];
        _ScrollView = [[KJScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160) ImageArr:arr];
    }
    return _ScrollView;
}

- (UICollectionView *)collectionView {
    if (nil == _collectionView) {
        float AD_height = 160;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, AD_height);//头部
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.minimumLineSpacing = 0.0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.alwaysBounceVertical = YES;
        [self.view addSubview:self.collectionView];
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        //注册cell和ReusableView（相当于头部）
        [self.collectionView registerClass:[ACollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        
        //设置collectionView的头视图
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)];
        _headView.backgroundColor=[UIColor grayColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_headView.frame), CGRectGetHeight(_headView.frame))];
        imageView.image = [UIImage imageNamed:@"login_register_background"];
        [_headView addSubview:imageView];
        
        dataource = [[NSMutableArray alloc] initWithObjects:@"充值",@"查询余额",@"关于我们",@"系统公告",@"我的客服",@"设置",@"系统公告",@"我的客服",@"设置",@"我的客服",@"设置", nil];
        imageDataSource = [[NSMutableArray alloc] initWithObjects:@"Profile_AddV_authen",@"Profile_AddV_authen",@"Profile_AddV_authen",@"Profile_AddV_authen",@"Profile_AddV_authen",@"Profile_AddV_authen",@"Profile_AddV_authen",@"Profile_AddV_authen",@"Profile_AddV_authen",@"Profile_AddV_authen",@"Profile_AddV_authen", nil];
    }
    
    return _collectionView;
}

#pragma mark -
#pragma mark --UIcolletionViewDelegate&dataSource--
//定义展示的UIcolletionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return dataource.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
//每个UIcolletionView展示的内容
-(ACollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    ACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    cell.imgView.image = [UIImage imageNamed:imageDataSource[indexPath.row]];
    cell.text.text = dataource[indexPath.row];
    return cell;
}
//头部显示的内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
        {
            [headerView addSubview:_headView];//头部广告栏
            break;
        }
        case 1:
        {
            [headerView addSubview:_ScrollView];
        }
            
        default:
            break;
    }
    
    
    
    return headerView;
    
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake((fDeviceWidth)/3, (fDeviceWidth)/3);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor redColor];
    NSLog(@"点击了%ld",(long)indexPath.row);
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
