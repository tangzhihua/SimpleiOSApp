//
//  INetLayerInterface.h
//
//  CoreLib
//
//  Created by skyduck on 2015-6-1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol INetRequestIsCancelled;
@protocol INetRequestHandle;

// 异步网络响应监听块
// ---> 成功
typedef void (^NetLayerAsyncNetResponseListenerInUIThreadSuccessedBlock)(id<INetRequestIsCancelled> netRequestIsCancelled, NSData *responseData);
// ---> 失败
typedef void (^NetLayerAsyncNetResponseListenerInUIThreadFailedBlock)(id<INetRequestIsCancelled> netRequestIsCancelled, NSError *error);
// ---> 进度
typedef void (^NetLayerAsyncNetResponseListenerInUIThreadProgressBlock)(double progress);


// "网络层" 提供给 "业务网络层" 的接口
@protocol INetLayerInterface <NSObject>

/**
 * 发起一个业务Bean的http请求
 *
 * @param urlString
 *
 * @param httpMethod
 *
 * @param netRequestOperationPriority
 *          请求优先级
 * @param dataDictionary
 *          数据字典(需要传递到服务器的参数)
 * @param successedBlock
 *          成功块
 * @param failedBlock
 *          失败块
 *
 * @return id<INetRequestHandle>
 */
- (id<INetRequestHandle>)requestDomainBeanWithUrlString:(in NSString *)urlString
                                             httpMethod:(in NSString *)httpMethod
                            netRequestOperationPriority:(in NSOperationQueuePriority)netRequestOperationPriority
                                         dataDictionary:(in NSDictionary *)dataDictionary
                                         successedBlock:(in NetLayerAsyncNetResponseListenerInUIThreadSuccessedBlock)successedBlock
                                            failedBlock:(in NetLayerAsyncNetResponseListenerInUIThreadFailedBlock)failedBlock;

- (id<INetRequestHandle>)requestFileWithUrlString:(in NSString *)urlString
                                       httpMethod:(in NSString *)httpMethod
                      netRequestOperationPriority:(in NSOperationQueuePriority)netRequestOperationPriority
                                   dataDictionary:(in NSDictionary *)dataDictionary
                               isNeedContinuingly:(in BOOL)isNeedContinuingly
                                 downLoadFilePath:(in NSString *)downLoadFilePath
                                    progressBlock:(in NetLayerAsyncNetResponseListenerInUIThreadProgressBlock)progressBlock
                                   successedBlock:(in NetLayerAsyncNetResponseListenerInUIThreadSuccessedBlock)successedBlock
                                      failedBlock:(in NetLayerAsyncNetResponseListenerInUIThreadFailedBlock)failedBlock;
@end
