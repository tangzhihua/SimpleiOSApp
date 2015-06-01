

#import "SimpleNetworkEngineSingleton.h"

// 业务模型相关
#import "IDomainBeanHelper.h"
#import "IParseNetRequestDomainBeanToDataDictionary.h"

// 网络层接口
#import "INetLayerInterface.h"

// 引擎配置相关
#import "IEngineHelper.h"
//#import "EngineHelperFactoryMethod.h"
//
#import "INetRequestParamsPackage.h"
#import "INetResponseRawEntityDataUnpack.h"
#import "IServerResponseDataValidityTest.h"
#import "INetResponseDataToNSDictionary.h"
#import "ISpliceFullUrlByDomainBeanSpecialPath.h"
#import "IDomainBeanRequestPublicParams.h"

#import "EngineHelperSingleton.h"

//
#import "BaseModel.h"

#import "ErrorBean.h"

// 监控/控制 网络请求的句柄
#import "INetRequestHandle.h"
#import "INetRequestIsCancelled.h"
// 一个实现INetRequestHandle接口的安全空对象
#import "NetRequestHandleNilObject.h"


#import "ErrorCodeEnum.h"


#import "IEngineHelper.h"

@interface SimpleNetworkEngineSingleton()

@end


@implementation SimpleNetworkEngineSingleton

static NSString *const TAG = @"SimpleNetworkEngineSingleton";

#pragma mark -
#pragma mark Singleton Implementation

// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
- (id)init {
  // 禁止调用 -init 或 +new
  RNAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

// 真正的(私有)init方法
- (id)initSingleton {
  
  if ((self = [super init])) {
    // 初始化代码
    
  }
  
  return self;
}

+ (SimpleNetworkEngineSingleton *)sharedInstance {
  static SimpleNetworkEngineSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark -
#pragma mark 内部方法群
- (NSOperationQueuePriority)netLayerOperationPriorityTransform:(NetRequestOperationPriority)netRequestOperationPriority {
  switch (netRequestOperationPriority) {
    case NetRequestOperationPriorityVeryLow:
      
      return NSOperationQueuePriorityVeryLow;
    case NetRequestOperationPriorityLow:
      
      return NSOperationQueuePriorityLow;
    case NetRequestOperationPriorityNormal:
      
      return NSOperationQueuePriorityNormal;
    case NetRequestOperationPriorityHigh:
      
      return NSOperationQueuePriorityHigh;
    case NetRequestOperationPriorityVeryHigh:
      
      return NSOperationQueuePriorityVeryHigh;
  }
}

#pragma mark -
#pragma mark 对外公开的方法

- (id<INetRequestHandle>)requestDomainBeanWithRequestDomainBean:(in id)netRequestDomainBean
                                                 successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                                    failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock{
  return [self requestDomainBeanWithRequestDomainBean:netRequestDomainBean
                          netRequestOperationPriority:NetRequestOperationPriorityNormal
                                           beginBlock:nil
                                       successedBlock:successedBlock
                                          failedBlock:failedBlock
                                             endBlock:nil];
}

/// 新的引擎接口
- (id<INetRequestHandle>)requestDomainBeanWithRequestDomainBean:(in id)netRequestDomainBean
                                                     beginBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadBeginBlock)beginBlock
                                                 successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                                    failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock
                                                       endBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadEndBlock)endBlock {
  return [self requestDomainBeanWithRequestDomainBean:netRequestDomainBean
                          netRequestOperationPriority:NetRequestOperationPriorityNormal
                                           beginBlock:beginBlock
                                       successedBlock:successedBlock
                                          failedBlock:failedBlock
                                             endBlock:endBlock];
}

/// 普通形式
- (id<INetRequestHandle>)requestDomainBeanWithRequestDomainBean:(in id)netRequestDomainBean
                                    netRequestOperationPriority:(in NetRequestOperationPriority)netRequestOperationPriority
                                                 successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                                    failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock {
  return [self requestDomainBeanWithRequestDomainBean:netRequestDomainBean
                          netRequestOperationPriority:NetRequestOperationPriorityNormal
                                           beginBlock:nil
                                       successedBlock:successedBlock
                                          failedBlock:failedBlock
                                             endBlock:nil];
}

/// 配合UI显示的形式
- (id<INetRequestHandle>)requestDomainBeanWithRequestDomainBean:(in id)netRequestDomainBean
                                    netRequestOperationPriority:(in NetRequestOperationPriority)netRequestOperationPriority
                                                     beginBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadBeginBlock)beginBlock
                                                 successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                                    failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock
                                                       endBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadEndBlock)endBlock {
  
  
  // 请求参数错误
  ErrorBean *requestParamsError = nil;
  
  do {
    if (netRequestDomainBean == nil || successedBlock == NULL || failedBlock == NULL) {
      requestParamsError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Client_IllegalArgument errorMessage:@"入参中有空值 netRequestDomainBean == nil || successedBlock == NULL || failedBlock == NULL"];
      break;
    }
    
    // 将 "网络请求业务Bean" 的 完整class name 作为和这个业务Bean对应的"业务接口" 绑定的所有相关的处理算法的唯一识别Key
    NSString *keyOfDomainBeanHelper = NSStringFromClass([netRequestDomainBean class]);
    PRPLog(@"\n\n\n\n\n\n\n\n\n-----------------> 请求接口 : %@\n\n\n", keyOfDomainBeanHelper);
    
    // 这里的设计使用了 "抽象工厂" 设计模式
    id<IDomainBeanHelper> domainBeanHelper = [EngineHelperSingleton sharedInstance].networkInterfaceMapping[keyOfDomainBeanHelper];
				
    // 获取当前业务网络接口, 对应的URL
    NSString *specialPath = [domainBeanHelper specialUrlPathWithNetRequestBean:netRequestDomainBean];
    NSString *fullUrlString = [[[EngineHelperSingleton sharedInstance] spliceFullUrlByDomainBeanSpecialPathFunction] fullUrlByDomainBeanSpecialPath:specialPath];
    if ([NSString isEmpty:fullUrlString]) {
      requestParamsError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Client_IllegalArgument errorMessage:[NSString stringWithFormat:@"接口 %@ 对应的URL为空.", keyOfDomainBeanHelper]];
      break;
    }
    
    // 发往服务器的 "数据字典"
    NSMutableDictionary *dataDictionary = [NSMutableDictionary dictionaryWithCapacity:50];
    // 公共参数
    NSDictionary *publicParams = [[[EngineHelperSingleton sharedInstance] domainBeanRequestPublicParamsFunction] publicParamsWithErrorOUT:&requestParamsError];
    if (requestParamsError != nil) {
      // 获取公共参数失败
      break;
    }
    [dataDictionary addEntriesFromDictionary:publicParams];
    
    // 具体接口的参数, 在这里会检测外部调用者传入的 "网络请求业务Bean" 是否有效.
    // TODO: 一定要保证先填充 "公共参数", 然后再填充 "具体接口的参数", 这是因为有时候具体接口的参数需要覆盖公共参数
    if ([domainBeanHelper parseNetRequestDomainBeanToDataDictionaryFunction] != nil) {
      
      [dataDictionary addEntriesFromDictionary:[[domainBeanHelper parseNetRequestDomainBeanToDataDictionaryFunction] parseNetRequestDomainBeanToDataDictionary:netRequestDomainBean error:&requestParamsError]];
      if (requestParamsError != nil) {
        // 将一个 "网络请求业务Bean" 解析成发往服务器的 "数据字典" 失败, 可能是外部调用者传递的参数无效
        break;
      }
    }
    
    // 调用网络层接口, 开始HTTP请求
    id<INetRequestHandle> requestHandle = [[[EngineHelperSingleton sharedInstance] netLayerInterfaceFunction] requestDomainBeanWithUrlString:fullUrlString httpMethod:[domainBeanHelper httpMethod] netRequestOperationPriority:[self netLayerOperationPriorityTransform:netRequestOperationPriority] dataDictionary:dataDictionary successedBlock:^(id<INetRequestIsCancelled> netRequestIsCancelled, NSData *responseData) {
      // 网络层数据正常返回
      
      // 网络响应业务Bean
      id netRespondBean = nil;
      // 服务器端响应数据错误
      ErrorBean *serverRespondDataError = nil;
      // 已经解包的数据字符串(UTF-8)
      NSString *netUnpackedDataOfUTF8String = nil;
      
      do {
        
        // ------------------------------------- >>>
        if ([netRequestIsCancelled isCancell]) {
          // 本次网络请求被取消了
          break;
        }
        // ------------------------------------- >>>
        
        NSData *netRawEntityData = responseData;
        if (![netRawEntityData isKindOfClass:[NSData class]] || netRawEntityData.length <= 0) {
          serverRespondDataError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Server_NoResponseData errorMessage:@"从服务器端获得的实体数据为空(EntityData)."];
          break;
        }
        PRPLog(@"\n\n\n-----------------> 接口 %@ : 返回的 \"实体生数据\" 不为空(netRawEntityData.length=%d)\n\n\n", keyOfDomainBeanHelper, netRawEntityData.length);
        
        // 将具体网络引擎层返回的 "原始未加工数据byte[]" 解包成 "可识别数据字符串(一般是utf-8)".
        // 这里要考虑网络传回的原生数据有加密的情况, 比如MD5加密的数据, 可以在这里先解密成可识别的字符串
        id<INetResponseRawEntityDataUnpack> netResponseRawEntityDataUnpackFunction = [[EngineHelperSingleton sharedInstance] netResponseRawEntityDataUnpackFunction];
        // 已经解密的可识别字符串(UTF8, 可能是JSON/XML/其他数据交换协议)
        netUnpackedDataOfUTF8String = [netResponseRawEntityDataUnpackFunction unpackNetResponseRawEntityDataToUTF8String:netRawEntityData];
        if ([NSString isEmpty:netUnpackedDataOfUTF8String]) {
          serverRespondDataError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Server_UnpackedResponseDataFailed errorMessage:@"解压缩服务器端返回的 \"实体数据(未解压的NSData类型的数据)\" 失败."];
          break;
        }
        PRPLog(@"\n\n\n-----------------> 接口 %@ : 解密服务器返回的 \"实体生数据\" 成功, 详细数据 =     \n\n%@\n\n\n", keyOfDomainBeanHelper, netUnpackedDataOfUTF8String);
        
        // 将 "数据交换协议字符串JSON/XML" 解析成 "cocoa 字典 NSDictionary"
        // 警告 : 这里假定服务器和客户端只使用一种 "数据交换协议" 进行通信.
        id<INetResponseDataToNSDictionary> netResponseDataToNSDictionaryFunction = [[EngineHelperSingleton sharedInstance] netResponseDataToNSDictionaryFunction];
        NSDictionary *responseDataDictionary = [netResponseDataToNSDictionaryFunction netResponseDataToNSDictionary:netUnpackedDataOfUTF8String];
        if (![responseDataDictionary isKindOfClass:[NSDictionary class]]) {
          serverRespondDataError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Server_ResponseDataToDictionaryFailed errorMessage:@"服务器返回的数据, 不能被成功解析成 Cocoa NSDictionary."];
          break;
        }
        PRPLog(@"\n\n\n-----------------> 接口 %@ : 将服务器返回的数据, 解析成数据字典成功, 详细数据 =     \n\n%@\n\n\n", keyOfDomainBeanHelper, responseDataDictionary);
        
        // 检查服务器返回的数据是否在逻辑上有效(所谓逻辑上有效, 就是看服务器是否返回和客户端约定好的错误码), 如果无效, 要获取服务器返回的错误码和错误描述信息
        // (比如说某次网络请求成功了(http级别的成功 http code是200), 但是服务器那边没有有效的数据给客户端, 所以服务器会返回错误码和描述信息告知客户端访问结果)
        id<IServerResponseDataValidityTest> serverResponseDataValidityTestFunction = [[EngineHelperSingleton sharedInstance] serverResponseDataValidityTestFunction];
        if (![serverResponseDataValidityTestFunction isServerResponseDataValid:responseDataDictionary errorOUT:&serverRespondDataError]) {
          PRPLog(@"\n\n\n-----------------> 接口 %@ : 服务器端告知客户端, 本次网络业务访问未获取到有效数据(具体情况--> %@\n\n\n", keyOfDomainBeanHelper, serverRespondDataError);
          break;
        }
        PRPLog(@"\n\n\n-----------------> 接口 %@ : 经过检验, 服务器返回的数据逻辑上有效\n\n", keyOfDomainBeanHelper);
        
        // 将 "数据字典" 直接通过 "KVC" 的方式转成 "业务Bean"
        @try {
          netRespondBean = [[[domainBeanHelper netRespondBeanClass] alloc] initWithDictionary:responseDataDictionary];
        } @catch (NSException *exception) {
          // 如果value的类型和bean中定义的不匹配时, 会抛出异常
          serverRespondDataError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Server_ParseDictionaryFailedToNetRespondBeanFailed errorMessage:@"将 \"数据字典\" 直接通过 \"KVC\" 的方式转成 \"网络响应业务Bean\" 失败."];
          break;
        }
        PRPLog(@"\n\n\n-----------------> 接口 %@ : 将 \"数据字典\" 直接通过 \"KVC\" 的方式转成 \"网络响应业务Bean\" 成功.\n\n", keyOfDomainBeanHelper);
        
        // 检查 netRespondBean 有效性.
        if (![domainBeanHelper isNetRespondBeanValidity:netRespondBean]) {
          serverRespondDataError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Server_KeyFieldLose errorMessage:@"服务器返回的数据, 丢失关键字段."];
          break;
        }
        PRPLog(@"\n\n\n-----------------> 接口 %@ : 经过检验, 创建的网络响应业务Bean %@ 有效\n打印详情:\n%@\n\n\n", keyOfDomainBeanHelper, NSStringFromClass([netRespondBean class]), [netRespondBean description]);
        
        
        // ----------------------------------------------------------------------------
        //
        PRPLog(@"\n\n\n-----------------> 接口 %@ : 本次网络业务请求, 圆满成功, 哦也!!!\n\n\n\n\n", keyOfDomainBeanHelper);
      } while (NO);
      
      // ------------------------------------- >>>
      // 通知控制层, 本次网络请求成功
      if (![netRequestIsCancelled isCancell]) {
        
        // ------------------------------------- >>>
        // 通知控制层, 本次网络请求结果
        if (serverRespondDataError == nil) {// 成功
          successedBlock(netRespondBean);
        } else {// 失败
          failedBlock(serverRespondDataError);
        }
        // ------------------------------------- >>>
        
        // ------------------------------------- >>>
        // 通知控制层, 本次网络请求彻底完成
        if (endBlock != NULL) {
          endBlock();
        }
        // ------------------------------------- >>>
        
      } else {
        PRPLog(@"\n\n\n-----------------> 接口 %@ : 网络请求, 已经被取消\n\n\n", keyOfDomainBeanHelper);
      }
      // ------------------------------------- >>>
      
      
      
      // ------------------------------------- >>>
      // 如果出现错误, 就向服务器发送log(优先保证客户端正常流程的响应性, 所以最后在发送log)
      if (serverRespondDataError != nil) {
        //NSString *fullErrorLog = [NSString stringWithFormat:@"概述:%@ ------------------ 服务器端返回的数据:%@", serverRespondDataError.errorMessage, netUnpackedDataOfUTF8String];
        //ErrorBean *errorLogBean = [ErrorBean errorBeanWithErrorCode:serverRespondDataError.errorCode errorMessage:fullErrorLog];
        //[[SdkLogCollectionSingleton sharedInstance] recordLogWithTag:TAG methodName:@"requestDomainBeanWithRequestDomainBean" errorBean:errorLogBean];
      }
      // ------------------------------------- >>>
      
    } failedBlock:^(id<INetRequestIsCancelled> netRequestIsCancelled, NSError *error) {
      // 发生网络请求错误
      PRPLog(@"\n\n\n-----------------> 接口 %@ : 网络层访问失败 , 原因-->\n\n%@\n\n\n", keyOfDomainBeanHelper, error.localizedDescription);
      
      // ------------------------------------- >>>
      // 通知控制层, 本次网络请求失败
      if (![netRequestIsCancelled isCancell]) {
        
        ErrorBean *errorBean = [ErrorBean errorBeanWithNSError:error];
        
        failedBlock(errorBean);
        
        // ------------------------------------- >>>
        // 通知控制层, 本次网络请求彻底完成
        if (endBlock != NULL) {
          endBlock();
        }
        // ------------------------------------- >>>
      } else {
        
        // 网络请求已经被取消
        PRPLog(@"\n\n\n-----------------> 接口 %@ : 网络请求, 已经被取消\n\n\n", keyOfDomainBeanHelper);
      }
      // ------------------------------------- >>>
      
      
    }];
    
    // 发起网络请求成功
    if (beginBlock != NULL) {
      // 通知控制层, 本次网络请求参数正确, 激活成功
      beginBlock();
    }
    return requestHandle;
  } while (NO);
  
  // 发起网络请求失败
  //[[SdkLogCollectionSingleton sharedInstance] recordLogWithTag:TAG methodName:@"requestDomainBeanWithRequestDomainBean" errorBean:requestParamsError];
  
  // 告知外部调用者, 错误原因
  if (failedBlock != NULL) {
    failedBlock(requestParamsError);
  }
  return [[NetRequestHandleNilObject alloc] init];
  
}

- (id<INetRequestHandle>)requestFileWithUrlString:(in NSString *)urlString
                                 downLoadFilePath:(in NSString *)downLoadFilePath
                                    progressBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadProgressBlock)progressBlock
                                   successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                      failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock {
  return [self requestFileWithUrlString:urlString
                             httpMethod:@"GET"
            netRequestOperationPriority:NetRequestOperationPriorityNormal
                         dataDictionary:nil
                     isNeedContinuingly:NO
                       downLoadFilePath:downLoadFilePath
                          progressBlock:progressBlock
                         successedBlock:successedBlock
                            failedBlock:failedBlock];
}

- (id<INetRequestHandle>)requestFileWithUrlString:(in NSString *)urlString
                                       httpMethod:(in NSString *)httpMethod
                      netRequestOperationPriority:(in NetRequestOperationPriority)netRequestOperationPriority
                                   dataDictionary:(in NSDictionary *)dataDictionary
                               isNeedContinuingly:(in BOOL)isNeedContinuingly
                                 downLoadFilePath:(in NSString *)downLoadFilePath
                                    progressBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadProgressBlock)progressBlock
                                   successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                      failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock {
  return [[[EngineHelperSingleton sharedInstance] netLayerInterfaceFunction] requestFileWithUrlString:urlString httpMethod:httpMethod netRequestOperationPriority:[self netLayerOperationPriorityTransform:netRequestOperationPriority] dataDictionary:dataDictionary isNeedContinuingly:isNeedContinuingly downLoadFilePath:downLoadFilePath progressBlock:^(double progress) {
    if (progressBlock != NULL) {
      progressBlock(progress);
    }
  } successedBlock:^(id<INetRequestIsCancelled> netRequestIsCancelled, NSData *responseData) {
    if (![netRequestIsCancelled isCancell]) {
      if (successedBlock != NULL) {
        successedBlock(responseData);
      }
    }
  } failedBlock:^(id<INetRequestIsCancelled> netRequestIsCancelled, NSError *error) {
    if (![netRequestIsCancelled isCancell]) {
      if (failedBlock != NULL) {
        failedBlock([ErrorBean errorBeanWithNSError:error]);
      }
    }
  }];
}
@end
