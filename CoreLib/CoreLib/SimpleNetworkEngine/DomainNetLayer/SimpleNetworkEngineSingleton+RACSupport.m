//
//  SimpleNetworkEngineSingleton+RACSupport.m
//  CoreLib
//
//  Created by skyduck on 15/7/1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import "SimpleNetworkEngineSingleton+RACSupport.h"

@implementation SimpleNetworkEngineSingleton (RACSupport)

- (RACSignal *)signalForNetRequestDomainBean:(in id)netRequestDomainBean {
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    id<INetRequestHandle> netRequestHandle
    = [[SimpleNetworkEngineSingleton sharedInstance] requestDomainBeanWithRequestDomainBean:netRequestDomainBean successedBlock:^(id respondDomainBean) {
      [subscriber sendNext:respondDomainBean];
      [subscriber sendCompleted];
    } failedBlock:^(ErrorBean *error) {
      [subscriber sendError:error];
    }];
    
    //
    return [RACDisposable disposableWithBlock:^{
      [netRequestHandle cancel];
    }];
  }];
}

- (RACSignal *)signalForNetRequestDomainBean:(in id)netRequestDomainBean
                                  isUseCache:(in BOOL)isUseCache {
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    id<INetRequestHandle> netRequestHandle
    = [[SimpleNetworkEngineSingleton sharedInstance] requestDomainBeanWithRequestDomainBean:netRequestDomainBean isUseCache:isUseCache successedBlock:^(id respondDomainBean) {
      [subscriber sendNext:respondDomainBean];
      [subscriber sendCompleted];
    } failedBlock:^(ErrorBean *error) {
      [subscriber sendError:error];
    }];
    
    //
    return [RACDisposable disposableWithBlock:^{
      [netRequestHandle cancel];
    }];
  }];
}

- (RACSignal *)signalForNetRequestDomainBean:(in id)netRequestDomainBean
                 netRequestOperationPriority:(in NetRequestOperationPriority)netRequestOperationPriority {
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    id<INetRequestHandle> netRequestHandle
    = [[SimpleNetworkEngineSingleton sharedInstance] requestDomainBeanWithRequestDomainBean:netRequestDomainBean netRequestOperationPriority:netRequestOperationPriority successedBlock:^(id respondDomainBean) {
      [subscriber sendNext:respondDomainBean];
      [subscriber sendCompleted];
    } failedBlock:^(ErrorBean *error) {
      [subscriber sendError:error];
    }];
    
    //
    return [RACDisposable disposableWithBlock:^{
      [netRequestHandle cancel];
    }];
  }];
}

- (RACSignal *)signalForNetRequestDomainBean:(in id)netRequestDomainBean
                                  isUseCache:(in BOOL)isUseCache
                 netRequestOperationPriority:(in NetRequestOperationPriority)netRequestOperationPriority {
  
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    id<INetRequestHandle> netRequestHandle
    = [[SimpleNetworkEngineSingleton sharedInstance] requestDomainBeanWithRequestDomainBean:netRequestDomainBean isUseCache:isUseCache netRequestOperationPriority:netRequestOperationPriority successedBlock:^(id respondDomainBean) {
      [subscriber sendNext:respondDomainBean];
      [subscriber sendCompleted];
    } failedBlock:^(ErrorBean *error) {
      [subscriber sendError:error];
    }];
    
    //
    return [RACDisposable disposableWithBlock:^{
      [netRequestHandle cancel];
    }];
  }];
}
@end
