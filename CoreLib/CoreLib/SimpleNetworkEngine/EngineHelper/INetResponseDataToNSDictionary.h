//
//  INetResponseDataToNSDictionary.h
//  KalendsPlatformSDK
//
//  Created by skyduck on 14-10-6.
//  Copyright (c) 2014年 Kalends. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 将已经解压的网络响应数据(UTF8String格式)转成 NSDictionary 数据
 * @author skyduck
 *
 */
@protocol INetResponseDataToNSDictionary <NSObject>
- (NSDictionary *)netResponseDataToNSDictionary:(in NSString *)serverResponseDataOfUTF8String;
@end
