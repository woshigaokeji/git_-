//
//  OrderModel.m
//  git_测试
//
//  Created by 马红涛 on 16/5/5.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+ (instancetype)OrderWithDic:(NSDictionary *)dic
{
    OrderModel *order = [[self alloc] init];
    [order setValuesForKeysWithDictionary:dic];
    return order;
}

@end
