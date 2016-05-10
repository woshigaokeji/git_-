//
//  DTableViewCell.m
//  git_测试
//
//  Created by 马红涛 on 16/5/9.
//  Copyright © 2016年 马红涛. All rights reserved.
//
#define DefaultFont [UIFont systemFontOfSize:12]
#import "DTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
@interface DTableViewCell() {
    UILabel *_View;
    UILabel *_View1;
    UILabel *_View2;
    UILabel *_View3;
    UILabel *_View4;
    UILabel *_View5;
}
//@property (weak, nonatomic) IBOutlet UILabel *TransactionType;
//@property (weak, nonatomic) IBOutlet UILabel *Date;
//@property (weak, nonatomic) IBOutlet UILabel *stock;
//@property (weak, nonatomic) IBOutlet UILabel *Money;
//@property (weak, nonatomic) IBOutlet UILabel *ConfirmDate;
//@property (weak, nonatomic) IBOutlet UILabel *TransactionStatus;

@end
@implementation DTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        label.font = DefaultFont;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
        label.layer.borderWidth=1.0f; //边框宽度
        label.layer.borderColor= [[UIColor blueColor] CGColor];//边框颜色
        label.textColor = [UIColor blueColor];
        _View = label;
        
        UILabel *label1 = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        _View1 = label1;
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.font = DefaultFont;
        label2.textAlignment = NSTextAlignmentRight;
        _View2 = label2;
        
        UILabel *label3 = [[UILabel alloc] init];
        label3.font = DefaultFont;
        label3.textColor = [UIColor lightGrayColor];
        _View3 = label3;
        
        UILabel *label4 = [[UILabel alloc] init];
        label4.font = DefaultFont;
        label4.textAlignment = NSTextAlignmentRight;
        label4.textColor = [UIColor lightGrayColor];
        _View4 = label4;
        
        UILabel *label5 = [[UILabel alloc] init];
        label5.font = DefaultFont;
        label5.textAlignment = NSTextAlignmentRight;
        _View5 = label5;
        
        [self.contentView sd_addSubviews:@[_View,_View1,_View2,_View3,_View4,_View5]];
        
        _View.sd_layout
        .widthIs(30)
        .heightIs(20)
        .leftSpaceToView(self.contentView,10)
        .topSpaceToView(self.contentView,10);
        
        _View1.sd_layout
        .topEqualToView(_View)
        .leftSpaceToView(_View,5)
        .rightSpaceToView(self.contentView,100)
        .heightRatioToView(_View,1);
        
        _View2.sd_layout
        .topEqualToView(_View)
        .leftSpaceToView(_View1,10)
        .rightSpaceToView(self.contentView,10)
        .heightRatioToView(_View1,1);
        
        _View3.sd_layout
        .leftEqualToView(_View)
        .topSpaceToView(_View1,10)
        .widthIs(120)
        .heightRatioToView(_View,1);
        
        _View5.sd_layout
        .topSpaceToView(_View1,10)
        .rightSpaceToView(self.contentView,5)
        .heightRatioToView(_View,1)
        .widthIs(60);
        
        _View4.sd_layout
        .topEqualToView(_View3)
        .rightSpaceToView(_View5,0)
        .heightRatioToView(_View3,1)
        .leftSpaceToView(_View3,10);
        
        [_View3 setSingleLineAutoResizeWithMaxWidth:150];
        [_View5 setSingleLineAutoResizeWithMaxWidth:60];
        [_View2 setSingleLineAutoResizeWithMaxWidth:120];
        
        //***********************高度自适应cell设置步骤************************
        //自适应的view-- 距离底部的位置
        [self setupAutoHeightWithBottomView:_View1 bottomMargin:30];
    }
    
    
    return self;
}

- (void)setModel:(TransactionRecordsModel *)model {
    
    _View.text = @"定投";
    _View1.text = model.stock;
    _View2.text = model.money;
    _View3.text = model.date;
    _View4.text = model.confirmDate;
    _View5.text = @"确认成功";
    [self transactionType:model.transactionType];
    [self transactionStatus:model.transactionStatus];
//    _Date.text = model.date;
//    _stock.text = model.stock;
//    _Money.text = model.money;
//    _ConfirmDate.text = model.confirmDate;
//    _TransactionStatus.text = model.transactionStatus;
}
- (void)transactionStatus:(TransactionStatus)type {
    switch (type) {
        case TyepDefault:
        {
           break;
        }
        case ongoing:
        {
            _View5.text = @"确认中";
            _View5.textColor = [UIColor redColor];
            break;
        }
        case success:
        {
            _View.text = @"确认成功";
            _View5.textColor = [UIColor greenColor];
            break;
        }
        case fail:
        {
            break;
        }
        default:
            break;
    }
}
- (void)transactionType:(TransactionType)type {
    switch (type) {
        case Default:
        {
            break;
        }
        case ShenGou:
        {
            break;
        }
        case DingTou:
        {
            _View.textColor = [UIColor blueColor];
            _View.layer.borderColor = [[UIColor blueColor] CGColor];//边框颜色
            _View.text = @"定投";
            break;
        }
        case ShuHui:
        {
            _View.textColor = [UIColor orangeColor];
            _View.layer.borderColor = [[UIColor orangeColor] CGColor];//边框颜色
            _View.text = @"赎回";
            break;
        }
        case CheDan:
        {
            break;
        }
        default:
            break;
    }
}

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
