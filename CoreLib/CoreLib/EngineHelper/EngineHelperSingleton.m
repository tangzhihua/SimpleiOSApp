
#import "EngineHelperSingleton.h"

#import "NetRequestParamsPackage.h"
#import "NetResponseRawEntityDataUnpack.h"
#import "NetResponseDataToNSDictionary.h"
#import "ServerResponseDataValidityTest.h"
#import "SpliceFullUrlByDomainBeanSpecialPath.h"
#import "DomainBeanRequestPublicParams.h"


// 网络接口 -- http engine
#import "HttpEngineOfMKNetworkKitSingleton.h"
// 具体网络
#import "NetworkInterfaceMappingSingleton.h"

static NSString *const TAG = @"EngineHelperSingleton";

@interface EngineHelperSingleton ()
@property (nonatomic, strong) id<INetRequestParamsPackage> netRequestParamsPackageFunction;
@property (nonatomic, strong) id<INetResponseRawEntityDataUnpack> netResponseRawEntityDataUnpackFunction;
@property (nonatomic, strong) id<INetResponseDataToNSDictionary> netResponseDataToNSDictionaryFunction;
@property (nonatomic, strong) id<IServerResponseDataValidityTest> serverResponseDataValidityTestFunction;
@property (nonatomic, strong) id<ISpliceFullUrlByDomainBeanSpecialPath> spliceFullUrlByDomainBeanSpecialPathFunction;
@property (nonatomic, strong) id<IDomainBeanRequestPublicParams> domainBeanRequestPublicParamsFunction;
@end

@implementation EngineHelperSingleton
#pragma mark -
#pragma mark 单例方法群

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
    
    _netRequestParamsPackageFunction = [[NetRequestParamsPackage alloc] init];
    _netResponseRawEntityDataUnpackFunction = [[NetResponseRawEntityDataUnpack alloc] init];
    _netResponseDataToNSDictionaryFunction = [[NetResponseDataToNSDictionary alloc] init];
    _serverResponseDataValidityTestFunction = [[ServerResponseDataValidityTest alloc] init];
    _spliceFullUrlByDomainBeanSpecialPathFunction = [[SpliceFullUrlByDomainBeanSpecialPath alloc] init];
    _domainBeanRequestPublicParamsFunction = [[DomainBeanRequestPublicParams alloc] init];
  }
  
  return self;
}

+ (EngineHelperSingleton *)sharedInstance {
  static EngineHelperSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark -
#pragma mark - 对外的接口

- (id<INetRequestParamsPackage>) netRequestParamsPackageFunction {
  return _netRequestParamsPackageFunction;
}
- (id<INetResponseRawEntityDataUnpack>) netResponseRawEntityDataUnpackFunction {
  return _netResponseRawEntityDataUnpackFunction;
}
// 将已经解压的网络响应数据(UTF8String格式)转成 NSDictionary 数据
- (id<INetResponseDataToNSDictionary>) netResponseDataToNSDictionaryFunction {
  return _netResponseDataToNSDictionaryFunction;
}
- (id<IServerResponseDataValidityTest>) serverResponseDataValidityTestFunction {
  return _serverResponseDataValidityTestFunction;
}
- (id<ISpliceFullUrlByDomainBeanSpecialPath>) spliceFullUrlByDomainBeanSpecialPathFunction {
  return _spliceFullUrlByDomainBeanSpecialPathFunction;
}
- (id<IDomainBeanRequestPublicParams>) domainBeanRequestPublicParamsFunction {
  return _domainBeanRequestPublicParamsFunction;
}


// 网络接口的映射 (requestBean ---> domainBeanHelper)
- (NSDictionary *) networkInterfaceMapping {
  return [NetworkInterfaceMappingSingleton sharedInstance].networkInterfaceMapping;
}


// 网络层接口(提供http相关服务)
- (id<INetLayerInterface>) netLayerInterfaceFunction {
  return [HttpEngineOfMKNetworkKitSingleton sharedInstance];
}
@end
