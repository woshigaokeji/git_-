//
//  KJScrollView.h
//  git_测试
//
//  Created by 马红涛 on 16/4/14.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJScrollView : UIView
/**
 *  初始化方法
 *
 *  @param frame    view的frame
 *  @param imageArr 循环播放图片的数组
 *
 *  @return 返回实例对象
 */
- (id)initWithFrame:(CGRect)frame ImageArr:(NSMutableArray *)imageArr;

@end
