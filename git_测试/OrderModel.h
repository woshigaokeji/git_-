//
//  OrderModel.h
//  git_测试
//
//  Created by 马红涛 on 16/5/5.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger) {
    OrderFail = 0,  // **< 等待状态 */
    orderSuccess,   // **< 成功状态 */
    OrderWaiting    // **< 失败状态 */
}orderType;
@interface OrderModel : NSObject

@property(nonatomic,copy)NSString *text;   /**< 文本内容 */
@property(nonatomic,copy)NSString *date;   /**< 日期    */
@property(nonatomic,assign)orderType type; /**< 订单状态 */
@property(nonatomic,copy)NSString *index;  /**< 订单的步骤 */

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 上划线 */
@property (nonatomic, strong) UIView *lineView;
/** 下划线 */
@property (nonatomic, strong) UIView *lastLineView;
+ (instancetype)OrderWithDic:(NSDictionary *)dic;
@end
