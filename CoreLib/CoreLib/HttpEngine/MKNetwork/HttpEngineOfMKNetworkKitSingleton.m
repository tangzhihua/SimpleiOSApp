

#import "HttpEngineOfMKNetworkKitSingleton.h"

//
#import "MKNetworkEngine.h"
//
#import "HttpRequestHandleOfMKNetworkKit.h"
#import "EngineHelperSingleton.h"
#import "IEngineHelper.h"
#import "INetRequestParamsPackage.h"

#import "NetRequestHandleNilObject.h"

#import "ErrorBean.h"
#import "ErrorCodeEnum.h"

static NSString *const TAG = @"HttpEngineOfMKNetworkKitSingleton";

@interface HttpEngineOfMKNetworkKitSingleton()

// 网络引擎
@property (nonatomic, strong) MKNetworkEngine *networkEngine;

@end

@implementation HttpEngineOfMKNetworkKitSingleton

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
    
    _networkEngine = [[MKNetworkEngine alloc] init];
    [_networkEngine registerOperationSubclass:[HttpRequestHandleOfMKNetworkKit class]];
  }
  
  return self;
}

+ (id<INetLayerInterface>) sharedInstance {
  static id<INetLayerInterface> singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark -
#pragma mark 实现 INetLayerInterface 协议
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
 *          数据字典
 * @param successedBlock
 *          成功块
 * @param failedBlock
 *          失败块
 *
 * @return id<KalendsINetRequestHandle>
 */
#define eKLRequestStringBoundary      @"3i2ndDfv2rTHiSisAbouNdArYfORhtTPEefj3q2f"

- (id<INetRequestHandle>)requestDomainBeanWithUrlString:(in NSString *)urlString
                                             httpMethod:(in NSString *)httpMethod
                            netRequestOperationPriority:(in NSOperationQueuePriority)netRequestOperationPriority
                                         dataDictionary:(in NSDictionary *)dataDictionary
                                         successedBlock:(in NetLayerAsyncNetResponseListenerInUIThreadSuccessedBlock)successedBlock
                                            failedBlock:(in NetLayerAsyncNetResponseListenerInUIThreadFailedBlock)failedBlock {
  
  
  PRPLog(@"\n\n\n\n\n\n\nhttp 访问相关信息\n-----------------> HTTP_URL = %@\n\n-----------------> HTTP_PARAMS = %@\n\n-----------------> HTTP_METHOD = %@\n\n-----------------> FULL_REQUEST_URL = \n%@\n\n\n\n\n\n\n", urlString, dataDictionary, httpMethod, [NSString stringWithFormat:@"%@%@", urlString, [dataDictionary urlEncodedKeyValueString]]);
  
  
  
  // 设置 公用的http header
  NSMutableDictionary *httpHeaders = [NSMutableDictionary dictionary];
  //
  
//  httpHeaders[@"Content-Type"] = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", eKLRequestStringBoundary];
//  httpHeaders[@"User-Agent"] = @"";
//  httpHeaders[@"Connection"] = @"Keep-Alive";
  
  MKNetworkOperation *netRequestOperation = (MKNetworkOperation *)[self.networkEngine operationWithURLString:urlString params:dataDictionary httpMethod:httpMethod];
  netRequestOperation.queuePriority = netRequestOperationPriority;
  // 设置 "当证书无效时, 也要继续网络访问" 标志位
  // TODO : 目前服务器就是这样配置的, 否则会发生 401错误, SSL -1202
  [netRequestOperation setShouldContinueWithInvalidCertificate:YES];
  [netRequestOperation addHeaders:httpHeaders];
  
  // 只有设置POST和PUT时, 才会调用
  //  [netRequestOperation setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
  //    NSData *httpEntityData = [[[EngineHelperFactoryMethod sharedInstance].engineHelper netRequestParamsPackageFunction] packageNetRequestParamsWithDomainDataDictionary:nil];
  //    return [[NSString alloc] initWithData:httpEntityData encoding:NSUTF8StringEncoding];
  //  } forType:nil];
  
  [netRequestOperation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
    
    NSData *netRawEntityData = [completedOperation responseData];
    successedBlock((id<INetRequestIsCancelled>)completedOperation, netRawEntityData);
  } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
    
    failedBlock((id<INetRequestIsCancelled>)completedOperation, error);
    
  }];
  
  [self.networkEngine enqueueOperation:netRequestOperation];
  
  return (id<INetRequestHandle>)netRequestOperation;
}

- (id<INetRequestHandle>)requestFileWithUrlString:(in NSString *)urlString
                                       httpMethod:(in NSString *)httpMethod
                      netRequestOperationPriority:(in NSOperationQueuePriority)netRequestOperationPriority
                                   dataDictionary:(in NSDictionary *)dataDictionary
                               isNeedContinuingly:(in BOOL)isNeedContinuingly
                                 downLoadFilePath:(in NSString *)downLoadFilePath
                                    progressBlock:(in NetLayerAsyncNetResponseListenerInUIThreadProgressBlock)progressBlock
                                   successedBlock:(in NetLayerAsyncNetResponseListenerInUIThreadSuccessedBlock)successedBlock
                                      failedBlock:(in NetLayerAsyncNetResponseListenerInUIThreadFailedBlock)failedBlock {
  
  // 请求参数错误
  ErrorBean *requestParamsError = nil;
  
  do {
    // 创建书籍保存路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![NSString isEmpty:downLoadFilePath]) {
      if (![fileManager fileExistsAtPath:downLoadFilePath]) {
        BOOL isCreateDirSuccess = [fileManager createDirectoryAtPath:downLoadFilePath
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:nil];
        if (!isCreateDirSuccess) {
          // 创建下载文件失败
          requestParamsError = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Client_IllegalState errorMessage:@"创建下载文件失败!"];
          break;
        }
      }
    }
    
    
    // 设置 公用的http header
    NSMutableDictionary *httpHeaders = [NSMutableDictionary dictionary];
    //
    //httpHeaders[@"Content-Type"] = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", eKLRequestStringBoundary];
    httpHeaders[@"User-Agent"] = @"";
    //httpHeaders[@"Connection"] = @"Keep-Alive";
    // 断点续传的支持
    if (isNeedContinuingly) {
      if ([fileManager fileExistsAtPath:downLoadFilePath]) {
        NSError *error = nil;
        unsigned long long fileSize = [[fileManager attributesOfItemAtPath:downLoadFilePath error:&error] fileSize];
        if (error == nil) {
          if (fileSize > 0) {
            NSString *headerRange = [NSString stringWithFormat:@"bytes=%llu-", fileSize];
            httpHeaders[@"Range"] = headerRange;
          }
        }
      }
    }
    
    MKNetworkOperation *netRequestOperation = [self.networkEngine operationWithURLString:urlString params:dataDictionary httpMethod:httpMethod];
    // 设置 "当证书无效时, 也要继续网络访问" 标志位
    // TODO : 目前服务器就是这样配置的, 否则会发生 401错误, SSL -1202
    //[netRequestOperation setShouldContinueWithInvalidCertificate:YES];
    [netRequestOperation addHeaders:httpHeaders];
    netRequestOperation.queuePriority = netRequestOperationPriority;
    
    //
    [netRequestOperation onDownloadProgressChanged:^(double progress) {
      if (progressBlock != NULL) {
        progressBlock(progress * 100);
      }
    }];
    //
    [netRequestOperation addCompletionHandler:^(MKNetworkOperation* completedRequest) {
      if (successedBlock != NULL) {
        successedBlock((id<INetRequestIsCancelled>)completedRequest, completedRequest.responseData);
      }
      
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
      if (failedBlock != NULL) {
        failedBlock((id<INetRequestIsCancelled>)errorOp, error);
      }
      
    }];
    
    [self.networkEngine enqueueOperation:netRequestOperation];
    
    return (id<INetRequestHandle>)netRequestOperation;
  } while (NO);
  
  // 发起网络请求失败
  //[[SdkLogCollectionSingleton sharedInstance] recordLogWithTag:TAG methodName:@"requestFileWithUrlString" errorBean:requestParamsError];
  
  // 告知外部调用者, 错误原因
  if (failedBlock != NULL) {
    failedBlock(nil, requestParamsError);
  }
  return [[NetRequestHandleNilObject alloc] init];
  
  
  
}
@end
