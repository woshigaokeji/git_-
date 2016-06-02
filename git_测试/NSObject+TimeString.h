//
//  NSObject+TimeString.h
//  git_测试
//
//  Created by 马红涛 on 16/5/31.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TimeString)
/**
 *  获取当前时间
 *
 *  @param format format: @"yyyy-MM-dd HH:mm:ss"、@"yyyy年MM月dd日 HH时mm分ss秒"
 *
 *  @return 年-月-日-分-秒
 */
+ (NSString *)currentDateWithFormat:(NSString *)format;

/**
 *  计算上次日期距离现在多久
 *
 *  @param lastTime    上次日期(需要和格式对应)
 *  @param format1     上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2     最近日期格式
 *
 *  @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2;

@end
