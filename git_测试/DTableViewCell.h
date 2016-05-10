//
//  DTableViewCell.h
//  git_测试
//
//  Created by 马红涛 on 16/5/9.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactionRecordsModel.h"
@interface DTableViewCell : UITableViewCell

@property(nonatomic,strong)TransactionRecordsModel *model;

+ (instancetype)cell;

@end
