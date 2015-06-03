//
//  NetRequestHandleNilObject.h
//
//  CoreLib
//
//  Created by skyduck on 2015-6-1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INetRequestHandle.h"

// 网络请求控制句柄, 安全空对象, 用于初始化
@interface NetRequestHandleNilObject : NSObject <INetRequestHandle>

@end
