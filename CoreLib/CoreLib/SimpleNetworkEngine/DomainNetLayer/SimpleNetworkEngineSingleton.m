

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
#pragma mark - request domainbean (全能方法)



/**
 * 发起一个网络接口的请求操作
 *
 * @param netRequestDomainBean        : 网络请求业务Bean(作用 : 1.标识想要请求的网络接口. 2.包装接口访问参数)
 * @param isUseCache                  : 是否要使用缓存, 如果设成YES, 会先读取本地缓存的数据, 本地没有缓存, 会从网络拉取最新的数据
 * @param netRequestOperationPriority : 本次网络请求发起后, 在请求队列中的优先级别.
 *
 * -------------      下面是生命周期的回调块       -------------
 *
 * @param beginBlock                  : 开始
 * @param successedBlock              : 成功
 * @param failedBlock                 : 失败
 * @param endBlock                    : 结束
 *
 * -------------      下面是生命周期的回调块       -------------
 *
 *
 */
- (id<INetRequestHandle>)requestDomainBeanWithRequestDomainBean:(in id)netRequestDomainBean
                                                     isUseCache:(in BOOL)isUseCache
                                    netRequestOperationPriority:(in NetRequestOperationPriority)netRequestOperationPriority
                                                     beginBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadBeginBlock)beginBlock
                                                 successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                                    failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock
                                                       endBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadEndBlock)endBlock {
  
  
  // 请求参数错误
  ErrorBean *requestParamsError = nil;
  
  do {
    // 入参检测
    if (netRequestDomainBean == nil || successedBlock == NULL || failedBlock == NULL) {
      requestParamsError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Client_IllegalArgument errorMessage:@"方法入参 netRequestDomainBean/successedBlock/failedBlock 不能为空."];
      break;
    }
    
    // "网络请求业务Bean" 作为一个网络接口的唯一标识, 它的类名(字符串格式), 作为跟这个接口有关的DomainBeanHelper的 Key Value 关联.
    NSString *const netRequestDomainBeanClassString = NSStringFromClass([netRequestDomainBean class]);
    
    PRPLog(@"\n\n\n\n\n\n\n\n\n-----------------> 请求接口 : %@\n\n\n", netRequestDomainBeanClassString);
    
    // domainBeanHelper 中包含了跟当前网络接口相关的一组助手方法(这里使用了 "抽象工厂" 设计模式)
    const id<IDomainBeanHelper> domainBeanHelper = [EngineHelperSingleton sharedInstance].networkInterfaceMapping[netRequestDomainBeanClassString];
    if (domainBeanHelper == nil) {
      requestParamsError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Client_ProgrammingError errorMessage:[NSString stringWithFormat:@"接口 [%@] 找不到与其对应的 domainBeanHelper, 客户端编程错误.", netRequestDomainBeanClassString]];
      break;
      break;
    }
    
    // 获取当前网络接口, 对应的URL
    NSString *const specialPath = [domainBeanHelper specialUrlPathWithNetRequestBean:netRequestDomainBean];
    NSString *const fullUrlString = [[[EngineHelperSingleton sharedInstance] spliceFullUrlByDomainBeanSpecialPathFunction] fullUrlByDomainBeanSpecialPath:specialPath];
    if ([NSString isEmpty:fullUrlString]) {
      requestParamsError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Client_IllegalArgument errorMessage:[NSString stringWithFormat:@"接口 [%@] 对应的 [%@] specialUrlPathWithNetRequestBean 方法返回nil, 客户端编程错误.", netRequestDomainBeanClassString, NSStringFromClass([domainBeanHelper class])]];
      break;
    }
    
    /// 发往服务器的 "数据字典"
    NSMutableDictionary *const dataDictionary = [NSMutableDictionary dictionaryWithCapacity:50];
    // 公共参数
    requestParamsError = nil;
    NSDictionary *const publicParams = [[[EngineHelperSingleton sharedInstance] domainBeanRequestPublicParamsFunction] publicParamsWithErrorOUT:&requestParamsError];
    if (requestParamsError != nil) {
      // 获取公共参数失败
      break;
    }
    [dataDictionary addEntriesFromDictionary:publicParams];
    
    // 具体接口的参数
    // 注意 : 一定要保证先填充 "公共参数", 然后再填充 "具体接口的参数", 这是因为有时候具体接口的参数需要覆盖公共参数.
    if ([domainBeanHelper parseNetRequestDomainBeanToDataDictionaryFunction] != nil) {
      requestParamsError = nil;
      NSDictionary *const privateParams = [[domainBeanHelper parseNetRequestDomainBeanToDataDictionaryFunction] parseNetRequestDomainBeanToDataDictionary:netRequestDomainBean error:&requestParamsError];
      if (requestParamsError != nil) {
        // 获取具体接口的私有参数失败
        break;
      }
      [dataDictionary addEntriesFromDictionary:privateParams];
    }
    
    // <------------------------------------------------------------------------------------------------------->
    /// 调用网络层接口, 开始HTTP请求
    id<INetRequestHandle> requestHandle = [[[EngineHelperSingleton sharedInstance] netLayerInterfaceFunction] requestDomainBeanWithUrlString:fullUrlString httpMethod:[domainBeanHelper httpMethod] netRequestOperationPriority:[self netLayerOperationPriorityTransform:netRequestOperationPriority] dataDictionary:dataDictionary successedBlock:^(id<INetRequestIsCancelled> netRequestIsCancelled, NSData *responseData) {
      
      // 网络层数据正常返回, 进入业务层的解析操作.
      
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
        
        NSData *const netRawEntityData = responseData;
        if (![netRawEntityData isKindOfClass:[NSData class]] || netRawEntityData.length <= 0) {
          serverRespondDataError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Server_NoResponseData errorMessage:@"从服务器端获得的实体数据为空(EntityData is nil)."];
          break;
        }
        PRPLog(@"\n\n\n-----------------> 接口 [%@] : 返回的 \"实体生数据\" 不为空(netRawEntityData.length=%d)\n\n\n", netRequestDomainBeanClassString, netRawEntityData.length);
        
        // 将网络层返回的 "生数据" 解包成 "可识别数据字符串(一般是utf-8)".
        // 这里要考虑网络传回的原生数据有加密的情况, 比如MD5加密的数据, 可以在这里先解密成可识别的字符串
        const id<INetResponseRawEntityDataUnpack> netResponseRawEntityDataUnpackFunction = [[EngineHelperSingleton sharedInstance] netResponseRawEntityDataUnpackFunction];
        // 已经解密的可识别字符串(UTF8, 可能是JSON/XML/其他数据交换协议)
        netUnpackedDataOfUTF8String = [netResponseRawEntityDataUnpackFunction unpackNetResponseRawEntityDataToUTF8String:netRawEntityData];
        if ([NSString isEmpty:netUnpackedDataOfUTF8String]) {
          serverRespondDataError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Server_UnpackedResponseDataFailed errorMessage:@"解包服务器端返回的 \"生数据\" 失败."];
          break;
        }
        PRPLog(@"\n\n\n-----------------> 接口 [%@] : 解包服务器返回的 \"生数据\" 成功, 详细数据 =     \n\n%@\n\n\n", netRequestDomainBeanClassString, netUnpackedDataOfUTF8String);
        
        // 将 "数据交换协议字符串JSON/XML" 解析成 "cocoa 字典 NSDictionary"
        // 警告 : 这里假定服务器和客户端只使用一种 "数据交换协议" 进行通信.
        const id<INetResponseDataToNSDictionary> netResponseDataToNSDictionaryFunction = [[EngineHelperSingleton sharedInstance] netResponseDataToNSDictionaryFunction];
        NSDictionary *const responseDataDictionary = [netResponseDataToNSDictionaryFunction netResponseDataToNSDictionary:netUnpackedDataOfUTF8String];
        if (![responseDataDictionary isKindOfClass:[NSDictionary class]]) {
          serverRespondDataError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Server_ResponseDataToDictionaryFailed errorMessage:@"服务器返回的数据, 不能被成功解析成 Cocoa NSDictionary."];
          break;
        }
        PRPLog(@"\n\n\n-----------------> 接口 [%@] : 将服务器返回的数据, 解析成 Cocoa NSDictionary 成功, 详细数据 =     \n\n%@\n\n\n", netRequestDomainBeanClassString, responseDataDictionary);
        
        // 检查服务器返回的数据是否在逻辑上有效(所谓逻辑上有效, 就是看服务器是否返回和客户端约定好的错误码), 如果无效, 要获取服务器返回的错误码和错误描述信息
        // (比如说某次网络请求成功了(http级别的成功 http code是200), 但是服务器那边没有有效的数据给客户端, 所以服务器会返回错误码和描述信息告知客户端访问结果)
        const id<IServerResponseDataValidityTest> serverResponseDataValidityTestFunction = [[EngineHelperSingleton sharedInstance] serverResponseDataValidityTestFunction];
        serverRespondDataError = nil;
        if (![serverResponseDataValidityTestFunction isServerResponseDataValid:responseDataDictionary errorOUT:&serverRespondDataError]) {
          PRPLog(@"\n\n\n-----------------> 接口 [%@] : 服务器端告知客户端, 本次网络业务访问未获取到有效数据(具体情况--> %@\n\n\n", netRequestDomainBeanClassString, serverRespondDataError);
          break;
        }
        PRPLog(@"\n\n\n-----------------> 接口 [%@] : 经过检验, 服务器返回的数据逻辑上有效\n\n", netRequestDomainBeanClassString);
        
        // 将 "数据字典" 直接通过 "KVC" 的方式转成 "网络响应业务Bean"
        @try {
          netRespondBean = [[[domainBeanHelper netRespondBeanClass] alloc] initWithDictionary:responseDataDictionary];
        } @catch (NSException *exception) {
          // 如果value的类型和bean中定义的不匹配时, 会抛出异常
          serverRespondDataError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Server_ParseDictionaryFailedToNetRespondBeanFailed errorMessage:@"将 \"数据字典\" 直接通过 \"KVC\" 的方式转成 \"网络响应业务Bean\" 失败."];
          break;
        }
        PRPLog(@"\n\n\n-----------------> 接口 [%@] : 将 \"数据字典\" 直接通过 \"KVC\" 的方式转成 \"网络响应业务Bean\" 成功.\n\n", netRequestDomainBeanClassString);
        
        // 检查 netRespondBean 有效性, 在这里要检查服务器返回的数据中, 是否丢失了核心字段.
        serverRespondDataError = nil;
        if (![domainBeanHelper isNetRespondBeanValidity:netRespondBean errorOUT:&serverRespondDataError]) {
          break;
        }
        PRPLog(@"\n\n\n-----------------> 接口 [%@] : 经过检验, 创建的网络响应业务Bean %@ 有效.\n打印详情:\n%@\n\n\n", netRequestDomainBeanClassString, NSStringFromClass([netRespondBean class]), [netRespondBean description]);
        
        
        // ----------------------------------------------------------------------------
        //
        PRPLog(@"\n\n\n-----------------> 接口 [%@] : 本次网络业务请求, 圆满成功, 哦也!!!\n\n\n\n\n", netRequestDomainBeanClassString);
      } while (NO);
      
      // ------------------------------------- >>>
      // 通知控制层, 本次网络请求成功
      if (![netRequestIsCancelled isCancell]) {
        
        // ------------------------------------- >>>
        // 通知控制层, 本次网络请求结果
        if (serverRespondDataError == nil) {// 业务层解析成功
          successedBlock(netRespondBean);
        } else {// 业务层解析失败
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
        PRPLog(@"\n\n\n-----------------> 接口 [%@] : 网络请求, 已经被取消.\n\n\n", netRequestDomainBeanClassString);
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
      // 网络层访问失败.
      PRPLog(@"\n\n\n-----------------> 接口 [%@] : 网络层访问失败 , 原因-->\n\n%@\n\n\n", netRequestDomainBeanClassString, error.localizedDescription);
      
      // ------------------------------------- >>>
      // 通知控制层, 本次网络请求失败
      if (![netRequestIsCancelled isCancell]) {
        
        failedBlock([ErrorBean errorBeanWithNSError:error]);
        
        // ------------------------------------- >>>
        // 通知控制层, 本次网络请求彻底完成
        if (endBlock != NULL) {
          endBlock();
        }
        // ------------------------------------- >>>
      } else {
        
        // 网络请求已经被取消
        PRPLog(@"\n\n\n-----------------> 接口 [%@] : 网络请求, 已经被取消.\n\n\n", netRequestDomainBeanClassString);
      }
      // ------------------------------------- >>>
      
      
    }];
    // <------------------------------------------------------------------------------------------------------->
    
    
    // 发起网络请求成功
    if (beginBlock != NULL) {
      // 通知控制层, 本次网络请求参数正确, 开始进行异步网络请求操作.
      beginBlock();
    }
    
    // 一切OK.
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

#pragma mark - request domainbean(重载方法群)

// --------------------              不带优先级的接口            -------------------------

/// 普通形式(不使用缓存/优先级默认是 NetRequestOperationPriorityNormal)
- (id<INetRequestHandle>)requestDomainBeanWithRequestDomainBean:(in id)netRequestDomainBean
                                                 successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                                    failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock {
  return [self requestDomainBeanWithRequestDomainBean:netRequestDomainBean
                                           isUseCache:NO
                          netRequestOperationPriority:NetRequestOperationPriorityNormal
                                           beginBlock:NULL
                                       successedBlock:successedBlock
                                          failedBlock:failedBlock
                                             endBlock:NULL];
}

/// 配合UI显示的形式(不使用缓存/优先级默认是 NetRequestOperationPriorityNormal)
- (id<INetRequestHandle>)requestDomainBeanWithRequestDomainBean:(in id)netRequestDomainBean
                                                     beginBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadBeginBlock)beginBlock
                                                 successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                                    failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock
                                                       endBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadEndBlock)endBlock {
  return [self requestDomainBeanWithRequestDomainBean:netRequestDomainBean
                                           isUseCache:NO
                          netRequestOperationPriority:NetRequestOperationPriorityNormal
                                           beginBlock:beginBlock
                                       successedBlock:successedBlock
                                          failedBlock:failedBlock
                                             endBlock:endBlock];
}

/// 普通形式(优先级默认是 NetRequestOperationPriorityNormal)
- (id<INetRequestHandle>)requestDomainBeanWithRequestDomainBean:(in id)netRequestDomainBean
                                                     isUseCache:(in BOOL)isUseCache
                                                 successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                                    failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock {
  return [self requestDomainBeanWithRequestDomainBean:netRequestDomainBean
                                           isUseCache:isUseCache
                          netRequestOperationPriority:NetRequestOperationPriorityNormal
                                           beginBlock:NULL
                                       successedBlock:successedBlock
                                          failedBlock:failedBlock
                                             endBlock:NULL];
}

/// 配合UI显示的形式(优先级默认是 NetRequestOperationPriorityNormal)
- (id<INetRequestHandle>)requestDomainBeanWithRequestDomainBean:(in id)netRequestDomainBean
                                                     isUseCache:(in BOOL)isUseCache
                                                     beginBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadBeginBlock)beginBlock
                                                 successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                                    failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock
                                                       endBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadEndBlock)endBlock {
  return [self requestDomainBeanWithRequestDomainBean:netRequestDomainBean
                                           isUseCache:isUseCache
                          netRequestOperationPriority:NetRequestOperationPriorityNormal
                                           beginBlock:beginBlock
                                       successedBlock:successedBlock
                                          failedBlock:failedBlock
                                             endBlock:endBlock];
}

// --------------------               带优先级的接口            -------------------------

/// 普通形式(不使用缓存)
- (id<INetRequestHandle>)requestDomainBeanWithRequestDomainBean:(in id)netRequestDomainBean
                                    netRequestOperationPriority:(in NetRequestOperationPriority)netRequestOperationPriority
                                                 successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                                    failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock {
  return [self requestDomainBeanWithRequestDomainBean:netRequestDomainBean
                                           isUseCache:NO
                          netRequestOperationPriority:netRequestOperationPriority
                                           beginBlock:NULL
                                       successedBlock:successedBlock
                                          failedBlock:failedBlock
                                             endBlock:NULL];
}

/// 配合UI显示的形式(不使用缓存)
- (id<INetRequestHandle>)requestDomainBeanWithRequestDomainBean:(in id)netRequestDomainBean
                                    netRequestOperationPriority:(in NetRequestOperationPriority)netRequestOperationPriority
                                                     beginBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadBeginBlock)beginBlock
                                                 successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                                    failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock
                                                       endBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadEndBlock)endBlock {
  return [self requestDomainBeanWithRequestDomainBean:netRequestDomainBean
                                           isUseCache:NO
                          netRequestOperationPriority:netRequestOperationPriority
                                           beginBlock:beginBlock
                                       successedBlock:successedBlock
                                          failedBlock:failedBlock
                                             endBlock:endBlock];
}

// --------------------               带缓存/优先级的接口(全能初始化方法)            -------------------------

/// 普通形式
- (id<INetRequestHandle>)requestDomainBeanWithRequestDomainBean:(in id)netRequestDomainBean
                                                     isUseCache:(in BOOL)isUseCache
                                    netRequestOperationPriority:(in NetRequestOperationPriority)netRequestOperationPriority
                                                 successedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadSuccessedBlock)successedBlock
                                                    failedBlock:(in DomainBeanAsyncHttpResponseListenerInUIThreadFailedBlock)failedBlock {
  return [self requestDomainBeanWithRequestDomainBean:netRequestDomainBean isUseCache:isUseCache beginBlock:NULL successedBlock:successedBlock failedBlock:failedBlock endBlock:NULL];
}


#pragma mark -
#pragma mark - request file
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
    
    // 向控制层回报下载进度
    if (progressBlock != NULL) {
      progressBlock(progress);
    }
  } successedBlock:^(id<INetRequestIsCancelled> netRequestIsCancelled, NSData *responseData) {
    
    // 文件下载成功
    if (![netRequestIsCancelled isCancell]) {
      if (successedBlock != NULL) {
        successedBlock(responseData);
      }
    }
  } failedBlock:^(id<INetRequestIsCancelled> netRequestIsCancelled, NSError *error) {
    
    // 文件下载失败
    if (![netRequestIsCancelled isCancell]) {
      if (failedBlock != NULL) {
        failedBlock([ErrorBean errorBeanWithNSError:error]);
      }
    }
  }];
}

@end
