//
//  IDomainBeanCacheControl.h
//  CoreLib
//
//  Created by skyduck on 15/6/6.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DomainBeanCacheModel;
@protocol IDomainBeanCacheControl <NSObject>
// 根据主键查询缓存的记录模型
- (DomainBeanCacheModel *)query:(DomainBeanCacheModel *)queryModel;
// 更新缓存的模型
- (void)update:(DomainBeanCacheModel *)latestModel;
// 删除指定的缓存
- (void)remove:(DomainBeanCacheModel *)removeModel;
// 清空全部缓存
- (void)clear;
@end
