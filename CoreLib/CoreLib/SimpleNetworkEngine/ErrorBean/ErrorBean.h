//
//  ErrorBean.h
//
//  CoreLib
//
//  Created by skyduck on 2015-6-1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface ErrorBean : NSError

@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, assign) NSInteger errorCode;

- (NSString *)localizedOption;
/**
 * 重新初始化
 *
 * @param srcObject
 */
- (void)reinitialize:(ErrorBean *)srcObject;

// 默认的初始化方法(会默认设置errorMessage=@"OK", errorCode=ErrorCodeEnum_Success)
- (id)init;

// 方便构造
+ (id)errorBeanWithErrorCode:(NSInteger)errorCode errorMessage:(NSString *)errorMessage;
+ (id)errorBeanWithNSError:(NSError *)error;
@end
