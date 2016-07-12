//
//  MessagingCell.m
//  git_测试
//
//  Created by 马红涛 on 16/5/31.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "MessagingCell.h"
@interface MessagingCell()

@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *text;
@property(nonatomic,strong)UIImageView *textImage;
@property(nonatomic,strong)UILabel *time;
@end
@implementation MessagingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImage];
        
        _text = [[UILabel alloc] init];
        _text.font = [UIFont systemFontOfSize:15];
        _text.numberOfLines = 0;
        [self.contentView addSubview:_text];
        
        _textImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_textImage];
        
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:12];
        _time.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_time];
        
//        self.backgroundColor = [UIColor colorWithRed:100/255 green:100/255 blue:100/255 alpha:1.0];
        
    }
    return self;
}

- (void)setModel:(MessagingModel *)model {
    _model = model;
    CGRect rect = [UIScreen mainScreen].bounds;
    _time.frame = CGRectMake(CGRectGetWidth(rect)/2 - 60, 5, 120, 10);
    _time.text = model.time;
    _time.textAlignment = NSTextAlignmentCenter;
    _text.frame = CGRectMake(40, CGRectGetMaxY(_time.frame) + 5, CGRectGetWidth(rect)-80, 40);
    CGSize size = [model.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_text.frame), 1000.0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _text.frame = CGRectMake(40, CGRectGetMaxY(_time.frame) + 5, CGRectGetWidth(rect)-80, size.height);
    
    if (model.textType == textTyep) {
        //纯文本
        _text.layer.cornerRadius = 1;
        _text.layer.borderColor = [UIColor blackColor].CGColor;
        _text.layer.borderWidth = 1;
        _text.text = model.text;
        if (size.height < 40) {
            model.height = 40;
        }else {
            model.height = CGRectGetMaxY(_text.frame);
        }
        if (model.messagingType == UserType && size.height > 40) {
            //我发的消息
            _text.textAlignment = NSTextAlignmentRight;
        }
    }else {
        //图片
        if (model.messagingType == UserType) {
            //我发的消息
            _textImage.frame = CGRectMake(CGRectGetWidth(rect) - 120, CGRectGetMaxY(_time.frame) + 5, 80, 80);
        }else {
            //别人发的消息
           _textImage.frame = CGRectMake(40, CGRectGetMaxY(_time.frame) + 5, 80, 80);
        }
        _textImage.image = [UIImage imageNamed:model.image];
        model.height = CGRectGetMaxY(_textImage.frame);
    }
    if (model.messagingType == UserType) {
        //我发的消息
        _headImage.frame = CGRectMake(CGRectGetWidth(rect) - 40, CGRectGetMaxY(_time.frame) + 5, 30, 30);
        
    }else {
        //别人发的消息
        _headImage.frame = CGRectMake(10, CGRectGetMaxY(_time.frame) + 5, 30, 30);
    }
    _headImage.image = [UIImage imageNamed:model.headImage];
    
    
    
}

@end
