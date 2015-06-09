//
//  DomainBeanCacheLayerSingleton.h
//  KalendsPlatformSDK
//
//  Created by skyduck on 14-10-6.
//  Copyright (c) 2014年 Kalends. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 ------------         业务Bean缓存层          ---------------
 
 Last update : 20150606
 
 设计思路 :
 之前看到 马蜂窝 app 的缓存机制, 感觉用户体验很好.
 简单思路是, 当用户发起网络请求时, 如果本地有缓存就加在缓存, 如果没有才进行联网操作.
 用户可以通过下拉刷新来刷新页面数据, 这种缓存机制也必须借助于外部UI的刷新机制, 否则刷新会不及时.
 
 之前我做过的app, 这种缓存机制都是由控制层来完成的,
 好处是灵活, 但同时也增加了控制层的代码量和设计难度, 尤其是很多界面离开后, 再次进入时就没有缓存了,
 这样就逼迫我在GlobalDataCacheForMemory中缓存了哪些我想全局缓存的数据.
 
 我想把那些暴露在外面(控制层)的模型缓存拿到 "引擎" 中来, 希望能够降低控制层的代码量和编码难度.
 
 简单思路是, 设计两层cache, 内存 + 闪存;
 内存缓存使用 NSCache, 闪存缓存使用 SQLite;
 
 由控制层决定是否使用缓存.
 
 业务层                           业务<-->网络 中转层                     网络层
 
       发起接口请求(使用缓存)
 ---------------------------->     判断 有缓存/无缓存
 
                                    有缓存
       返回给业务层
 <----------------------------
                                    无缓存
                                                       请求网络
                                            ------------------------->
 
                                                       新数据
                                            <-------------------------
                                  添加缓存/更新缓存
       返回给业务层
 <-----------------------------
 
 
 业务Bean 缓存记录模型(DomainBeanCacheModel) 设计
 我希望把缓存的细节隐藏起来, 所以真正的缓存模块和外部通过此 模型 进行通讯.
 
 缓存的设计 : 
 缓存分为两层 : 内存 + 闪存.
 内存缓存使用 NSCache, 闪存缓存使用 SQLite;
 
 缓存模块只提供缓存, 但是不包含缓存有效性的逻辑, 有效性逻辑在当前层决定(比如普通缓存7天失效, 列表数据缓存3秒失效)
 
 
 
 ----------------------------------------------------------
 */

@interface DomainBeanCacheLayerSingleton : NSObject
+ (DomainBeanCacheLayerSingleton *) sharedInstance;

- (id)readNetRespondBeanWithRequestBeanClass:(in Class)requestBeanClass
                            respondBeanClass:(in Class)respondBeanClass
                               requestParams:(in NSDictionary *)requestParams;

- (void)writeNetRespondBeanWithRequestBeanClass:(in Class)requestBeanClass
                                  requestParams:(in NSDictionary *)requestParams
                                    respondData:(in NSString *)respondData;
@end
