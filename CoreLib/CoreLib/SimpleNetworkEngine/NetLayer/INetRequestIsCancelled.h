//
//  INetRequestIsCancelled.h
//  KalendsPlatformSDK
//
//  Created by skyduck on 14-10-6.
//  Copyright (c) 2014年 Kalends. All rights reserved.
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
