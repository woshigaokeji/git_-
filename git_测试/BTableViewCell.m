//
//  BTableViewCell.m
//  git_测试
//
//  Created by 马红涛 on 16/4/29.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "BTableViewCell.h"

#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@implementation BTableViewCell
{
    UIView *_view0;
    UIView *_view1;
    UILabel *_view2;
    UIView *_view3;
    UIView *_view4;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *view0 = [UIImageView new];
        view0.image = [UIImage imageNamed:@"mine-icon-manhua"];
        view0.backgroundColor = [UIColor redColor];
        _view0 = view0;
        
        UIView *view1 = [UIView new];
        view1.backgroundColor = [UIColor blueColor];
        _view1 = view1;
        
        UILabel *View2 = [UILabel new];
        View2.backgroundColor = [UIColor brownColor];
        _view2 = View2;
        
        UILabel *view3 = [UILabel new];
        view3.backgroundColor = [UIColor orangeColor];
        _view3 = view3;
        
        UIView *view4 = [UIView new];
        view4.backgroundColor = [UIColor purpleColor];
        _view4 = view4;
        
        [self.contentView sd_addSubviews:@[view0,view1,View2,view3,view4]];
        
        _view0.sd_layout
        .widthIs(50)
        .heightIs(50)
        .leftSpaceToView(self.contentView,10)
        .topSpaceToView(self.contentView,10);
        
        _view1.sd_layout
        .topEqualToView(_view0)
        .leftSpaceToView(_view0,10)
        .rightSpaceToView(self.contentView,10)
        .heightRatioToView(_view0,0.4);
        
        _view2.sd_layout
        .topSpaceToView(_view1,10)
        .leftEqualToView(_view1)
        .rightEqualToView(_view1)
        .autoHeightRatio(0);
        
        _view3.sd_layout
        .topSpaceToView(_view2,10)
        .leftEqualToView(_view2)
        .rightSpaceToView(self.contentView,100)
        .heightRatioToView(_view1,1);
        
        _view4.sd_layout
        .topEqualToView(_view3)
        .leftSpaceToView(_view3,10)
        .rightEqualToView(_view1)
        .heightRatioToView(_view1,1);
        
        //***********************高度自适应cell设置步骤************************
        
        [self setupAutoHeightWithBottomView:_view4 bottomMargin:10];
    }
    
    return self;
}

- (void)setText:(NSString *)text {
    _text = text;
    
    _view2.text = text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
