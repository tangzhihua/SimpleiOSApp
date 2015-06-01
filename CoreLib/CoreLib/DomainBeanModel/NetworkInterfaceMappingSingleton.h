//
//  NetworkInterfaceMappingForKunlun.h
//  KalendsPlatformSDK
//
//  Created by skyduck on 14-10-6.
//  Copyright (c) 2014年 Kalends. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络接口
 */
@interface NetworkInterfaceMappingSingleton : NSObject

@property (nonatomic, readonly) NSMutableDictionary *networkInterfaceMapping;

+ (NetworkInterfaceMappingSingleton *) sharedInstance;
@end
