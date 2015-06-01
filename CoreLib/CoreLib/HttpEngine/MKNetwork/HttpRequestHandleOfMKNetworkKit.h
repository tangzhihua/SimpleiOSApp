//
//  HttpRequestHandleOfMKNetworkKit.h
//  KalendsPlatformSDK
//
//  Created by skyduck on 14-10-6.
//  Copyright (c) 2014年 Kalends. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkOperation.h"
#import "INetRequestHandle.h"
#import "INetRequestIsCancelled.h"

@interface HttpRequestHandleOfMKNetworkKit : MKNetworkOperation <INetRequestHandle, INetRequestIsCancelled>

@end
