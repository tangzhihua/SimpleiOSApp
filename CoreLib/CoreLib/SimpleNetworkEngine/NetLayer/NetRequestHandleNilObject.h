//
//  NetRequestHandleNilObject.h
//  KalendsPlatformSDK
//
//  Created by skyduck on 14-10-6.
//  Copyright (c) 2014年 Kalends. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INetRequestHandle.h"

// 网络请求控制句柄, 安全空对象, 用于初始化
@interface NetRequestHandleNilObject : NSObject <INetRequestHandle>

@end
