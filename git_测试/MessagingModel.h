//
//  MessagingModel.h
//  git_测试
//
//  Created by 马红涛 on 16/6/1.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger) {
    UserType,    //我的信息
    OtherType    //其他人的信息
}MessagingType;
typedef NS_ENUM(NSInteger) {
    textTyep,      //纯文本
    ImageType      //图片
}TextType;
@interface MessagingModel : NSObject

@property (nonatomic,copy  ) NSString      *text;   /**< 文本内容 */
@property (nonatomic,copy  ) NSString      *time;   /**< 时间 */
@property (nonatomic,copy  ) NSString      *image;  /**< 图片 */
@property (nonatomic,assign) MessagingType messagingType;     /**< 消息发送者 */
@property (nonatomic,assign) TextType      textType;          /**< 发送文本类型 */
@property (nonatomic,assign) NSString      *headImage;        /**< 头像 */
@property (nonatomic,assign) CGFloat height;    /**< cell的高度 */
/**
 *  初始化方法
 *
 *  @param text          文本内容
 *  @param time          时间
 *  @param image         图片
 *  @param messagingType 消息发送者
 *  @param textType      发送文本类型
 *
 *  @return 返回messagingModel
 */
- (id)initWithText:(NSString *)text
              time:(NSString *)time
             image:(NSString *)image
     messagingType:(MessagingType)messagingType
          textType:(TextType)textType
         headImage:(NSString *)headImage;

@end
