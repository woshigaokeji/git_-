//
//  KJMenuView.h
//  git_测试
//
//  Created by 马红涛 on 16/5/10.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJMenuView : UIView




/**
 *  初始化方法
 *
 *  @param frame    view的frame
 *  @param titleArr 标题数组
 *  @param textArr  装每个标题选项的数组,可以是一维数组,也可以是二维数组
 *  @param count    有多少个标题数组
 *  @return 返回实例对象
 */
- (id)initWithFrame:(CGRect)frame
           TitleArr:(NSArray *)titleArr
            TextArr:(NSArray *)textArr
         titleCount:(NSInteger)count;

- (void)showView;
- (void)hidView;
@end
