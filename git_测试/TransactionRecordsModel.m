//
//  TransactionRecordsModel.m
//  git_测试
//
//  Created by 马红涛 on 16/5/9.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "TransactionRecordsModel.h"

@implementation TransactionRecordsModel

+ (instancetype)OrderWithDic:(NSDictionary *)dic
{
    TransactionRecordsModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

@end
