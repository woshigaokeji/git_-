//
//  KJPerSon.m
//  git_测试
//
//  Created by 马红涛 on 16/5/5.
//  Copyright © 2016年 马红涛. All rights reserved.
//

#import "KJPerSon.h"

@implementation KJPerSon
static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    }
    
    return _instance;
}

+ (instancetype)sharedInstance {
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

@end
