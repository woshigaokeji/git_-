//
//  KJMenuView.m
//  git_测试
//
//  Created by 马红涛 on 16/5/10.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "KJMenuView.h"
@interface KJMenuView()
{
    NSArray *TextModel;  //**< 所有层的数据 */
    NSMutableArray *SelectRow;   //**< 保存每一层选中数据 */
    
}
@property(nonatomic,strong)UIButton *SureBtn;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *blankView;
@end

@implementation KJMenuView

- (id)initWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr TextArr:(NSArray *)textArr titleCount:(NSInteger)count{
    self = [super initWithFrame:frame];
    CGFloat height = 0;
    if (self) {
        SelectRow = [NSMutableArray array];
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0)];
        _bgView.backgroundColor = [UIColor whiteColor];
        //默认子视图的范围根据父视图的显示而显示
        _bgView.clipsToBounds = YES;
        
        
        _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetMaxY(_bgView.frame))];
        _blankView.backgroundColor = [UIColor lightGrayColor];
        _blankView.alpha = 0.0;
        _blankView.clipsToBounds = YES;
        _blankView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapAction:)];
        [_blankView addGestureRecognizer:tap];
        [self addSubview:_blankView];
        for (int i = 0; i<count; i++) {
            //title初始化view
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 40*(i+1), CGRectGetWidth(self.frame) - 10, 1)];
            view.backgroundColor = [UIColor lightGrayColor];
            view.alpha = 0.7;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(view.frame),CGRectGetMaxY(view.frame) - 30, 60, 20)];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor lightGrayColor];
            label.text = titleArr[i];
            
            [_bgView addSubview:view];
            [_bgView addSubview:label];
            
            if (i == count - 1) {
                height = CGRectGetMaxY(view.frame);
            }
        }
        TextModel = textArr;
        NSInteger textCount = textArr.count;
        for (int i = 0; i<textCount; i++) {
            NSArray *text = textArr[i];
            CGFloat width = 40;
            CGFloat gap = (CGRectGetWidth(self.frame) - 70)/text.count - 40;
            for (int j = 0; j < text.count; j++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.tag = 1+j + i*10;
                btn.frame = CGRectMake(70 + (gap+width)*j, 10 + 40*i, width, 20);
                btn.titleLabel.font = [UIFont systemFontOfSize:10];
//                btn.titleLabel.textColor = [UIColor lightGrayColor];
                [btn setTitle:text[j] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
                [_bgView addSubview:btn];
                if (j == 0) {
                    //默认选项--不限
                    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                    [SelectRow addObject:[NSString stringWithFormat:@"%d",j]];
                    
                }
            }
        }
        //确认按钮
        _SureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat BtnWidth = 140;
        _SureBtn.frame = CGRectMake(CGRectGetWidth(self.frame)/2 - BtnWidth/2, height + 20, BtnWidth, 40);
        [_SureBtn setBackgroundColor:[UIColor colorWithRed:0.4 green:0.8 blue:1.0 alpha:1.0]];
        [_SureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _SureBtn.layer.cornerRadius = 5.0;
        _SureBtn.layer.borderWidth = 1.0;
        _SureBtn.layer.borderColor = [[UIColor clearColor] CGColor];
        [_SureBtn addTarget:self action:@selector(SureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_SureBtn];
        [self addSubview:_bgView];
        
        _MenuHidden = YES;
    }
    
    return self;
}
- (void)showView {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.hidden = NO;
        _blankView.hidden = NO;
        _blankView.alpha = 0.6f;
        _bgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 160);
    } completion:^(BOOL finished) {
        _MenuHidden = NO;
        
    }];
}
- (void)hidView {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        _blankView.frame = CGRectMake(0, CGRectGetMaxY(_bgView.frame), CGRectGetWidth(self.frame), 0);
//        _blankView.alpha = 0.0f;
        _bgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 0);
    } completion:^(BOOL finished) {
        //这里不移除视图
        _MenuHidden = YES;
        self.hidden = YES;
        _blankView.hidden = YES;
    }];
    //回收视图的时候回调代理
    if (self.delegate) {
        [self.delegate selectBtn:SelectRow];
    }
}
//按钮点击事件
- (void)BtnAction:(UIButton *)sender {
    NSInteger textCount = TextModel.count;
    NSInteger index = sender.tag;
    for (int i = 0; i<textCount; i++) {
        NSArray *text = TextModel[i];
        NSInteger count = 0;
        for (int j = 0; j < text.count; j++) {
            NSInteger tag = 1 + j + i*10;
            if (index == tag) {
                count ++;
                //保存选中的btn位置
                SelectRow[i] = [NSString stringWithFormat:@"%d",j];
                NSLog(@"selectRow = %@",SelectRow);
            }
            
        }
        for (int j = 0; j < text.count; j++) {
            NSInteger tag = 1 +j + i*10;
            if (count) {
                
                UIButton *btn = (UIButton *)[_bgView viewWithTag:tag];
                [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            }
        }
    }
    [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}
//确认按钮点击事件
- (void)SureBtnAction:(UIButton *)sender {
    [self hidView];
}
//点击背景图回收视图
- (void)TapAction:(UITapGestureRecognizer *)sender {
    [self hidView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
