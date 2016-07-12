//
//  CTableViewCell.m
//  git_测试
//
//  Created by 马红涛 on 16/5/5.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "CTableViewCell.h"
@interface CTableViewCell()

@property(nonatomic,strong)UIView *lineView;     //上划线
@property(nonatomic,strong)UIView *lastLineView; //下划线
@property(nonatomic,strong)UIImageView *TypeImageView; //状态图片
@property(nonatomic,strong)UILabel *text;              //文本内容
@property(nonatomic,strong)UILabel *datelabel;         //日期

@end
@implementation CTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lineView = [[UIView alloc] init];
        [self.contentView addSubview:_lineView];
        
        _lastLineView = [[UIView alloc] init];
        [self.contentView addSubview:_lastLineView];
        
        _TypeImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_TypeImageView];
        
        _text = [[UILabel alloc] init];
        [self.contentView addSubview:_text];
        
        _datelabel = [[UILabel alloc] init];
        _datelabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_datelabel];
    }
    
    return self;
}

- (void)setModel:(OrderModel *)model {
    _lineView.frame = CGRectMake(30, 0, 1, 35);
    _lastLineView.backgroundColor = [UIColor lightGrayColor];
    switch (model.type) {
        case 0:
        {
            //订单步骤失败状态
            _lineView.backgroundColor = [UIColor redColor];
            _TypeImageView.image = [UIImage imageNamed:@"失败"];
            _text.textColor = [UIColor redColor];
            break;
        }
        case 1:
        {
            //订单步骤成功状态
            //步骤完成
            _lineView.backgroundColor = [UIColor greenColor];
            _TypeImageView.image = [UIImage imageNamed:@"步骤完成"];
            _text.textColor = [UIColor greenColor];
            break;
        }
        case 2:
        {
            //订单步骤等待状态
            //步骤未完成
            _lineView.backgroundColor = [UIColor lightGrayColor];
            _TypeImageView.image = [UIImage imageNamed:@"步骤未完成"];
            _text.textColor = [UIColor lightGrayColor];
            break;
        }
            
            
        default:
            break;
    }
    
    _TypeImageView.frame = CGRectMake(CGRectGetMinX(_lineView.frame) - 15, CGRectGetMaxY(_lineView.frame), 30, 30);
    
    _text.frame = CGRectMake(CGRectGetMaxX(_TypeImageView.frame) + 10, CGRectGetMinY(_TypeImageView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(_TypeImageView.frame));
    _text.text = model.text;
    
    _datelabel.frame = CGRectMake(CGRectGetMinX(_text.frame), CGRectGetMaxY(_text.frame), CGRectGetWidth(self.frame), CGRectGetHeight(_text.frame));
    _datelabel.text = model.date;
    //步骤4
    if ([model.index integerValue] == 4) {
        _text.font = [UIFont systemFontOfSize:12];
        switch (model.type) {
            case 0:
            {
                //订单步骤失败状态
                _text.textColor = [UIColor redColor];
                _TypeImageView.image = [UIImage imageNamed:@"失败状态 "];
                _lineView.backgroundColor = [UIColor redColor];
               break;
            }
            case 1:
            {
                //最后一个步骤状态(完成状态)
                _text.textColor = [UIColor greenColor];
                _TypeImageView.image = [UIImage imageNamed:@"已完成状态"];
                _lineView.backgroundColor = [UIColor greenColor];
                break;
            }
            case 2:
            {
                //订单步骤未完成状态
                //未完成状态
                _text.textColor = [UIColor lightGrayColor];
                _TypeImageView.image = [UIImage imageNamed:@"未完成状态 "];
                _lineView.backgroundColor = [UIColor lightGrayColor];
                break;
            }
                
            default:
                break;
        }
        _lastLineView.frame = CGRectZero;
    }else {
        
        _lastLineView.frame = CGRectMake(CGRectGetMinX(_lineView.frame), CGRectGetMaxY(_lineView.frame) + 5, 1, CGRectGetHeight(_text.frame) + CGRectGetHeight(_datelabel.frame));
    }
    //保存当前cell的高度
    model.cellHeight = CGRectGetMaxY(_datelabel.frame);
    //保存当前lastLineView,方便下一个步骤状态设置颜色
    model.lastLineView = _lastLineView;
    model.lineView = _lineView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
