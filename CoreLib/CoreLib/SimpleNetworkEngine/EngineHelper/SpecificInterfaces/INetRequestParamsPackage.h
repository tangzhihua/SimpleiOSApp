//
//  INetRequestParamsPackage.h
//
//  CoreLib
//
//  Created by skyduck on 2015-6-1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
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


