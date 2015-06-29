
#import "LoginManager.h"
#import "SimpleNetworkEngineSingleton.h"

@interface LoginManager ()
// 注意 : 如果重写 setter=setLoggingIn: 会导致 isLoggingIn 属性KVO失效
//@property (nonatomic, assign, setter=setLoggingIn:, readwrite) BOOL isLoggingIn;
@property (nonatomic, assign, readwrite) BOOL isLoggingIn;

@end

@implementation LoginManager {
  dispatch_queue_t _syncQueue;
}

@synthesize isLoggingIn = _isLoggingIn;


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
  
}

- (RACSignal *)createLoginSignalWithNetRequestBean:(LoginNetRequestBean *)loginNetRequestBean {
  @weakify(self);
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    @strongify(self);
    
    self.isLoggingIn = YES;
    __block id<INetRequestHandle> netRequestHandleForLoing;
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      netRequestHandleForLoing
      = [[SimpleNetworkEngineSingleton sharedInstance] requestDomainBeanWithRequestDomainBean:loginNetRequestBean isUseCache:NO successedBlock:^(id respondDomainBean) {
        [subscriber sendNext:respondDomainBean];
        [subscriber sendCompleted];
      } failedBlock:^(ErrorBean *error) {
        [subscriber sendError:error];
      }];
    });
    
    
    
    return [RACDisposable disposableWithBlock:^{
      self.isLoggingIn = NO;
      [netRequestHandleForLoing cancel];
    }];
  }];
}
@end
