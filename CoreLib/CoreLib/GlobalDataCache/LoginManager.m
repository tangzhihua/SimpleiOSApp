
#import "LoginManager.h"
#import "SimpleNetworkEngineSingleton.h"

@interface LoginManager ()
// 注意 : 如果重写 setter=setLoggingIn: 会导致 isLoggingIn 属性KVO失效
//@property (nonatomic, assign, setter=setLoggingIn:, readwrite) BOOL isLoggingIn;
//@property (nonatomic, assign, readwrite) BOOL isLoggingIn;

@property (nonatomic, readwrite, strong) LoginNetRespondBean *latestLoginNetRespondBean;
@end

@implementation LoginManager {
  dispatch_queue_t _syncQueue;
}

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
  self = [super init];
  if ((self = [super init])) {
    // 初始化代码
    
    _syncQueue = dispatch_get_global_queue((dispatch_queue_priority_t)DISPATCH_DATA_DESTRUCTOR_DEFAULT, 0);
  }
  
  return self;
}

+ (instancetype)sharedInstance {
  static id singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark -

- (void)logout {
  self.latestLoginNetRespondBean = nil;
}

- (RACSignal *)signalForLoginWithLoginNetRequestBean:(LoginNetRequestBean *)loginNetRequestBean {
  
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    id<INetRequestHandle> netRequestHandleForLoing
    = [[SimpleNetworkEngineSingleton sharedInstance] requestDomainBeanWithRequestDomainBean:loginNetRequestBean successedBlock:^(id respondDomainBean) {
      
      self.latestLoginNetRespondBean = respondDomainBean;
      
      [subscriber sendNext:respondDomainBean];
      [subscriber sendCompleted];
    } failedBlock:^(ErrorBean *error) {
      [subscriber sendError:error];
    }];

    return [RACDisposable disposableWithBlock:^{
      [netRequestHandleForLoing cancel];
    }];
  }];
}
@end
