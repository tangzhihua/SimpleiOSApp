//
//  IParseNetRequestDomainBeanToDataDictionary.h
//
//  CoreLib
//
//  Created by skyduck on 2015-6-1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>

// 将一个请求业务Bean解析成数据字典
@protocol IParseNetRequestDomainBeanToDataDictionary <NSObject>
/**
 *  将一个 "网络请求业务Bean" 解析成发往服务器的 "数据字典", 在这里设置的Key, 是跟服务器约定好的
 *
 *  @param netRequestDomainBean 网络请求业务Bean
 *  @param error                如果出现错误, 就通过这个error参数传递出去, 错误的原因可能用户传入的 netRequestDomainBean 无效
 *
 *  @return "发往服务器的数据字典"
 */
- (NSDictionary *)parseNetRequestDomainBeanToDataDictionary:(in id)netRequestDomainBean error:(out ErrorBean **)errorOUT;
@end
