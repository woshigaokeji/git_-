//
//  NSString+pinyin.h
//  CFStringTransform汉字转拼音
//
//  Created by 马文星 on 15/10/30.
//  Copyright © 2015年 马文星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (pinyin)


///拼音 ->pinyin
-(NSString*)transformToPinyin;

///拼音首字母 -> py
- (NSString *)transformToPinyinFirstLetter;

@end
