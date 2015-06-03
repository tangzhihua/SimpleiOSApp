//
//  INetRequestIsCancelled.h
//
//  CoreLib
//
//  Created by skyduck on 2015-6-1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>

// 判断当前网络请求是否已经被取消了
@protocol INetRequestIsCancelled <NSObject>
/**
 * 判断当前网络请求是否已经被取消
 *
 * @return
 */
- (BOOL)isCancell;
@end
