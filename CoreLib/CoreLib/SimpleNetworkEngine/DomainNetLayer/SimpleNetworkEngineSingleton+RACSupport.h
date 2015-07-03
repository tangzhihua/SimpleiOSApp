//
//  SimpleNetworkEngineSingleton+RACSupport.h
//  CoreLib
//
//  Created by skyduck on 15/7/1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import "SimpleNetworkEngineSingleton.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

/*
 说明 : 为了配合使用ReactiveCocoa框架, 我们的网络引擎进行的适配
 */
@interface SimpleNetworkEngineSingleton (RACSupport)

// 最普通形式(不使用Cache/优先级是NetRequestOperationPriorityNormal)
- (RACSignal *)signalForNetRequestDomainBean:(in id)netRequestDomainBean;

// 带缓存设置的形式(优先级是NetRequestOperationPriorityNormal)
- (RACSignal *)signalForNetRequestDomainBean:(in id)netRequestDomainBean
                                  isUseCache:(in BOOL)isUseCache;

// 带优先级设置的形式(不使用Cache)
- (RACSignal *)signalForNetRequestDomainBean:(in id)netRequestDomainBean
                 netRequestOperationPriority:(in NetRequestOperationPriority)netRequestOperationPriority;

// 完整形式
- (RACSignal *)signalForNetRequestDomainBean:(in id)netRequestDomainBean
                                  isUseCache:(in BOOL)isUseCache
                 netRequestOperationPriority:(in NetRequestOperationPriority)netRequestOperationPriority;
@end
