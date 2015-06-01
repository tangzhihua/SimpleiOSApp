//
//  IEngineHelper.h
//  KalendsPlatformSDK
//
//  Created by skyduck on 14-10-6.
//  Copyright (c) 2014年 Kalends. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 引擎助手接口
 * @author zhihua.tang
 *
 */
@protocol INetRequestParamsPackage;
@protocol INetResponseRawEntityDataUnpack;
@protocol IServerResponseDataValidityTest;
@protocol INetResponseDataToNSDictionary;
@protocol ISpliceFullUrlByDomainBeanSpecialPath;
@protocol IDomainBeanRequestPublicParams;
@protocol INetLayerInterface;

@protocol IEngineHelper <NSObject>

// 根据httpRequestMethod和domainDataDictionary来打包RequestParams(可以在这里进行数据的加密工作)
- (id<INetRequestParamsPackage>) netRequestParamsPackageFunction;
// 将网络返回的原生数据, 解压成可识别的UTF8字符串(在这里完成数据的解密)
- (id<INetResponseRawEntityDataUnpack>) netResponseRawEntityDataUnpackFunction;
// 服务器返回的数据有效性检测(这是业务层面有效性检测, 比如说, 调用后台一个搜索接口, 传入关键字, 在后台没有搜索到结果的情况下, 在业务层面, 我们认为是失败的)
- (id<IServerResponseDataValidityTest>) serverResponseDataValidityTestFunction;
// 将已经解压的网络响应数据(UTF8String格式)转成 NSDictionary 数据
- (id<INetResponseDataToNSDictionary>) netResponseDataToNSDictionaryFunction;
// 拼接一个网络接口的完整请求URL
- (id<ISpliceFullUrlByDomainBeanSpecialPath>) spliceFullUrlByDomainBeanSpecialPathFunction;
// 业务Bean请求时,需要传递到服务器的公共参数
- (id<IDomainBeanRequestPublicParams>) domainBeanRequestPublicParamsFunction;


// 网络接口的映射
// requestBean ---> domainBeanHelper
- (NSDictionary *) networkInterfaceMapping;

// 网络层接口
- (id<INetLayerInterface>) netLayerInterfaceFunction;

@end

