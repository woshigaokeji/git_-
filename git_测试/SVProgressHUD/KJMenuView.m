//
//  KJMenuView.m
//  git_测试
//
//  Created by 马红涛 on 16/5/10.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "KJMenuView.h"
@interface KJMenuView()

@property(nonatomic,strong)UIButton *SureBtn;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *blankView;
@end

@implementation KJMenuView

- (id)initWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr TextArr:(NSArray *)textArr titleCount:(NSInteger)count{
    self = [super initWithFrame:frame];
    CGFloat height = 0;
    if (self) {
//        self.backgroundColor = [UIColor lightGrayColor];
//        self.alpha = 0.7;
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetMaxY(_bgView.frame))];
        _blankView.backgroundColor = [UIColor lightGrayColor];
        _blankView.alpha = 0.5;
        _blankView.clipsToBounds = YES;
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
        NSInteger textCount = textArr.count;
        for (int i = 0; i<textCount; i++) {
            NSArray *text = textArr[i];
            CGFloat width = 40;
            CGFloat gap = (CGRectGetWidth(self.frame) - 70)/text.count - 40;
            for (int j = 0; j < text.count; j++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(70 + (gap+width)*j, 10 + 40*i, width, 20);
                btn.titleLabel.font = [UIFont systemFontOfSize:10];
//                btn.titleLabel.textColor = [UIColor lightGrayColor];
                [btn setTitle:text[j] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [_bgView addSubview:btn];
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
        [_bgView addSubview:_SureBtn];
        [self addSubview:_bgView];
    }
    
    return self;
}
- (void)showView {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _blankView.frame = CGRectMake(0, CGRectGetMaxY(_bgView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetMaxY(_bgView.frame));
        _bgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 160);
        _blankView.alpha = 0.4f;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)hidView {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _blankView.frame = CGRectMake(0, CGRectGetMaxY(_bgView.frame), CGRectGetWidth(self.frame), 0);
        _blankView.alpha = 0.0f;
        _bgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
