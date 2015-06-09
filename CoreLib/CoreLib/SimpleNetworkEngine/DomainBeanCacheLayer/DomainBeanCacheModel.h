//
//  DomainBeanCacheModel.h
//  CoreLib
//
//  Created by skyduck on 15/6/5.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DomainBeanCacheModel : NSObject
// 主键
@property (nonatomic, copy, readonly) NSString *primaryKey;
// 服务器返回的原始数据(比如JSON字符串)
@property (nonatomic, copy, readonly) NSString *respondData;
// 数据最后更新时间
@property (nonatomic, copy, readonly) NSString *lastDate;

#pragma mark -
#pragma mark - 构造方法
- (id)initWithPrimaryKey:(NSString *)primaryKey respondData:(NSString *)respondData lastDate:(NSString *)lastDate;

- (id)init DEPRECATED_ATTRIBUTE;
@end
