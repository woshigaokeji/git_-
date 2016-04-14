//
//  ACollectionViewCell.m
//  git_测试
//
//  Created by 马红涛 on 16/4/14.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "ACollectionViewCell.h"

@implementation ACollectionViewCell
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), 1)];
        lable1.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
        UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame), 0, 1, CGRectGetHeight(self.contentView.frame))];
        lable2.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
        UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.contentView.frame), CGRectGetWidth(self.contentView.frame), 1)];
        lable3.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
        UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, CGRectGetHeight(self.contentView.frame))];
        lable4.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
        [self addSubview:lable1];
        [self addSubview:lable2];
        [self addSubview:lable3];
        [self addSubview:lable4];
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2 - 20, 20, 40, 40)];
        [self addSubview:self.imgView];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame)+10, CGRectGetWidth(self.frame), 30)];
        //        self.text.backgroundColor = [UIColor brownColor];
        self.text.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.text];
    }
    
    return self;
}

@end
