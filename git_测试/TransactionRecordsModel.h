//
//  TransactionRecordsModel.h
//  git_测试
//
//  Created by 马红涛 on 16/5/9.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger) {
    Default = 0,  // **< 不限 */
    ShenGou,   // **< 申购 */
    DingTou,    // **< 定投 */
    ShuHui,     // **< 赎回 */
    CheDan     // **<撤单 */
}TransactionType;
typedef NS_ENUM(NSInteger) {
    TyepDefault = 0,  // **< 不限 */
    ongoing,          // **< 进行中 */
    success,          // **< 处理成功 */
    fail,             // **< 处理失败 */
}TransactionStatus;
@interface TransactionRecordsModel : NSObject

@property(nonatomic,copy)NSString *stock;   /**< 股票*/
@property(nonatomic,copy)NSString *date;   /**< 日期    */
@property(nonatomic,assign)TransactionType transactionType; /**< 交易类型 */
@property(nonatomic,copy)NSString *money;  /**< 订单价格 */
@property(nonatomic,copy)NSString *confirmDate;   /**< 确认日期 */
@property(nonatomic,assign)TransactionStatus transactionStatus;  /**< 交易状态 */

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 初始化方法 */
+ (instancetype)OrderWithDic:(NSDictionary *)dic;

@end
