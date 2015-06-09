

#import "DomainBeanCacheLayerSingleton.h"

#import "ErrorBean.h"
#import "ErrorCodeEnum.h"
#import "NSString+MKNetworkKitAdditions.h"


#import "DomainBeanCacheModel.h"
#import "DomainBeanMemoryCacheSingleton.h"
#import "DomainBeanDiskCacheSingleton.h"

static NSString *const TAG = @"DomainBeanCacheLayerSingleton";

@interface DomainBeanCacheLayerSingleton()

@end

@implementation DomainBeanCacheLayerSingleton {
  
}

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

+ (DomainBeanCacheLayerSingleton *) sharedInstance {
  static DomainBeanCacheLayerSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark - 私有方法
- (NSString *)cacheRecordPrimaryKeyWithRequestBeanClassName:(in NSString *)requestBeanClassName
                                              requestParams:(in NSDictionary *)requestParams {
  NSMutableString *primaryKey = [NSMutableString stringWithString:requestBeanClassName];
  [requestParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [primaryKey appendString:key];
    [primaryKey appendString:obj];
  }];
  return [primaryKey md5];
}

#pragma mark - 对外公开的方法
- (id)readNetRespondBeanWithRequestBeanClass:(in Class)requestBeanClass
                            respondBeanClass:(in Class)respondBeanClass
                               requestParams:(in NSDictionary *)requestParams {
  
  id domainBeanModel = nil;
  
  NSString *cacheRecordPrimaryKey = [self cacheRecordPrimaryKeyWithRequestBeanClassName:NSStringFromClass(requestBeanClass) requestParams:requestParams];
  DomainBeanCacheModel *queryModel = [[DomainBeanCacheModel alloc] initWithPrimaryKey:cacheRecordPrimaryKey respondData:nil lastDate:nil];
  DomainBeanCacheModel *cacheModel = [[DomainBeanMemoryCacheSingleton sharedInstance] query:queryModel];
  if (cacheModel == nil) {
    cacheModel = [[DomainBeanDiskCacheSingleton sharedInstance] query:queryModel];
  }
  if (cacheModel != nil) {
    long long nowTimestamp = (long long)[[NSDate date] timeIntervalSince1970];
    
    // 超过7天的缓存将被删除
    if (nowTimestamp - [cacheModel.lastDate longLongValue] <= 60 * 60 * 24 * 7) {
      [[DomainBeanMemoryCacheSingleton sharedInstance] remove:cacheModel];
      [[DomainBeanDiskCacheSingleton sharedInstance] remove:cacheModel];
      cacheModel = nil;
    } else {
      
      // 将缓存的json数据转成数据字典
      NSError *error = nil;
      NSData *data = [cacheModel.respondData dataUsingEncoding:NSUTF8StringEncoding];
      NSDictionary *jsonRootNSDictionary =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
      // 将数据字典直接映射成模型
      domainBeanModel = [[respondBeanClass alloc] initWithDictionary:jsonRootNSDictionary];
 
    }
  }

  return domainBeanModel;
}

- (void)writeNetRespondBeanWithRequestBeanClass:(in Class)requestBeanClass
                                  requestParams:(in NSDictionary *)requestParams
                                    respondData:(in NSString *)respondData {
  NSString *cacheRecordPrimaryKey = [self cacheRecordPrimaryKeyWithRequestBeanClassName:NSStringFromClass(requestBeanClass) requestParams:requestParams];
  long long nowTimestamp = (long long)[[NSDate date] timeIntervalSince1970];
  DomainBeanCacheModel *updateModel = [[DomainBeanCacheModel alloc] initWithPrimaryKey:cacheRecordPrimaryKey respondData:respondData lastDate:[[NSNumber numberWithLongLong:nowTimestamp] stringValue]];
  [[DomainBeanMemoryCacheSingleton sharedInstance] update:updateModel];
  [[DomainBeanDiskCacheSingleton sharedInstance] update:updateModel];
  return;
}
@end
