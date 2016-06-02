//
//  MessagingModel.m
//  git_测试
//
//  Created by 马红涛 on 16/6/1.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "MessagingModel.h"

@implementation MessagingModel
- (id)initWithText:(NSString *)text
              time:(NSString *)time
             image:(NSString *)image
     messagingType:(MessagingType)messagingType
          textType:(TextType)textType
         headImage:(NSString *)headImage {
    self = [super init];
    if (self) {
        _text = text;
        _time = time;
        _image = image;
        _messagingType = messagingType;
        _textType = textType;
        _headImage = headImage;
    }
    return self;
}
@end
