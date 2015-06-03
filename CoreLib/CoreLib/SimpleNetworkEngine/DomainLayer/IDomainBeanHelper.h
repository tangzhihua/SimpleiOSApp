//
//  IDomainBeanHelper.h
//
//  CoreLib
//
//  Created by skyduck on 2015-6-1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IParseNetRequestDomainBeanToDataDictionary;
@protocol IParseNetRespondDictionaryToDomainBean;

/**
 * 每个网络接口都会对应一套 NetRequestBean 和 NetRespondBean
 * 每个网络接口需要做的抽象都在这里进行了定义
 * 每个网络接口都需要实现这里定义的接口
 * 每个接口的 __NetRequestBean 和 __DomainBeanHelper 成映射关系, 比如 LoginNetRequestBean 对应 LoginDomainBeanHelper
 *
 * @author skyduck
 */
@protocol IDomainBeanHelper <NSObject>

@required
/**
 * 将NetRequestDomainBean(网络请求业务Bean), 解析成发往服务器的数据字典(key要跟服务器定义的接口协议对应, value可以在这里进行二次处理, 比如密码的md5加密)
 * @return
 */
- (id<IParseNetRequestDomainBeanToDataDictionary>)parseNetRequestDomainBeanToDataDictionaryFunction;

/**
 * 当前网络接口, 对应的URL(api path)
 * @return
 */
- (NSString *)specialUrlPathWithNetRequestBean:(id)netRequestBean;

/**
 * 当前网络接口对应的NetRespondBean
 * 我们使用KVC的方式直接从字典和Class映射成具体的模型对象, 这里设置的就是要转换的 [NetRespondBean Class]
 * @return
 */
- (Class)netRespondBeanClass;

/**
 * 检查当前NetRespondBean是否有效
 * 这里的设计含义是 : 我们因为直接使用KVC, 将网络返回的数据字典直接解析成NetRespondBean, 但是这里有个隐患, 就是服务器返回的数据字典可能和本地的NetRespondBean字段不匹配, 所以每个NetRespondBean都应该设计有核心字段的概念, 只要服务器返回的数据字典包含有核心字典, 就认为本次数据有效,比如说登录接口,当登录成功后, 服务器会返回username和uid和其他一些字段, 那么uid和username就是核心字段, 只要这两个字段有效就可以认为本次网络请求有效
 * @return
 */
- (BOOL)isNetRespondBeanValidity:(in id)netRespondBean errorOUT:(out ErrorBean **)errorOUT;

/**
 * 考虑到后台不是同时都支持GET和POST请求, 而做的设计
 * @return
 */
- (NSString *)httpMethod;

@end
