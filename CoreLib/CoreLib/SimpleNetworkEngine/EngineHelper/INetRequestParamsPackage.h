//
//  INetRequestParamsPackage.h
//  KalendsPlatformSDK
//
//  Created by skyduck on 14-10-6.
//  Copyright (c) 2014年 Kalends. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 根据httpRequestMethod和domainDataDictionary来打包RequestParams(可以在这里进行数据的加密工作)
 *
 * @author skyduck
 */
@protocol INetRequestParamsPackage <NSObject>

/**
 *  将业务数据字典, 打包成POST方式传递的数据
 *
 *  @param domainDD 业务数据字典
 *
 *  @return 打包之后的POST数据
 */
- (NSData *)packageNetRequestParamsWithDomainDataDictionary:(in NSDictionary *)domainDD;
@end


