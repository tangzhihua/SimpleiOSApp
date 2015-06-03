//
//  INetResponseRawEntityDataUnpack.h
//  KalendsPlatformSDK
//
//  Created by skyduck on 14-10-6.
//  Copyright (c) 2014年 Kalends. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 将网络返回的原生数据, 解压成可识别的UTF8字符串(在这里完成数据的解密)
 * @author zhihua.tang
 *
 */
@protocol INetResponseRawEntityDataUnpack <NSObject>
- (NSString *)unpackNetResponseRawEntityDataToUTF8String:(in NSData *)rawData;
@end

