//
//  ErrorCodeEnum.h
//
//  CoreLib
//
//  Created by skyduck on 2015-6-1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#ifndef CoreLib_ErrorCodeEnum_h
#define CoreLib_ErrorCodeEnum_h

// 网络请求时, 错误码枚举
// 错误码说明 : 包容了 http 错误码(2000以内的数字)
typedef NS_ENUM(NSInteger, ErrorCodeEnum) {
  // 网络访问成功(也就是说从服务器获取到了正常的有效数据)
  ErrorCodeEnum_Success = 200,
  
  
  
  
  
  /// 客户端错误
  ErrorCodeEnum_Client_Error = 1000,
  ErrorCodeEnum_Client_ProgrammingError = 1001, // 客户端编程错误
  ErrorCodeEnum_Client_IllegalArgument = 1002, // 方法的参数错误
  ErrorCodeEnum_Client_NullPointer = 1003, // 空指针
  ErrorCodeEnum_Client_MethodReturnValueInvalid = 1004, // 方法返回值无效(就是调用一个有返回值的方法, 结果发现返回值无效)
  ErrorCodeEnum_Client_NetRequestBeanInvalid = 1005, // 网络请求业务Bean无效
  ErrorCodeEnum_Client_IllegalState = 1006,// 违法的状态异常。当在Java环境和应用尚未处于某个方法的合法调用状态，而调用了该方法时，抛出该异常。
  
  /// 服务器错误
  ErrorCodeEnum_Server_Error = 2000,
  
  // 从服务器端获得的实体数据为空(EntityData), 这种情况有可能是正常的, 比如 退出登录 接口, 服务器就只是通知客户端访问成功, 而不发送任何实体数据.
  ErrorCodeEnum_Server_NoResponseData                 = 2001,
  // 解析服务器端返回的实体数据失败, 在netUnpackedDataOfUTF8String不为空的时候, unpackNetResponseRawEntityDataToUTF8String是绝对不能为空的.
  ErrorCodeEnum_Server_UnpackedResponseDataFailed     = 2002,
  // 将网络返回的数据转换成 "字典" 失败, 可能原因是服务器和客户端的数据协议不同步照成的, 比如说客户端需要JSON, 而服务器返回的数据格式不是JSON
  ErrorCodeEnum_Server_ResponseDataToDictionaryFailed = 2003,
  // 将数据字典, 通过KVC的方式, 解析成业务Bean失败.
  ErrorCodeEnum_Server_ParseDictionaryFailedToNetRespondBeanFailed = 2004,
  // 本次网络返回的数据, 丢失关键字段(也可能是服务器和客户端数据协议发生变化, 导致和本地NetRespondBean不匹配)
  ErrorCodeEnum_Server_KeyFieldLose = 2004,
  
  
  /// 和服务器约定好的错误码, 联网成功, 但是服务器那边发生了错误, 服务器要告知客户端错误的详细信息
  ErrorCodeEnum_Server_Custom_Error = 20000,
  ErrorCodeEnum_Server_invalid_client = 20001,     //
  ErrorCodeEnum_Server_invalid_request = 20002,     //
  ErrorCodeEnum_Server_invalid_token = 20003,     //
  ErrorCodeEnum_Server_expired_token = 20004,     //
  ErrorCodeEnum_Server_insufficient_scope = 20005,     //
  ErrorCodeEnum_Server_unsupported_grant_type = 20006,     //
  ErrorCodeEnum_Server_unauthorized_client = 20007,     //
  ErrorCodeEnum_Server_invalid_grant = 20008,     //
  ErrorCodeEnum_Server_invalid_scope = 20009,     //
 
};


#endif
