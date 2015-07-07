//
//  OrdersViewModel.m
//  SimpleiOSApp
//
//  Created by skyduck on 15/7/7.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import "OrdersViewModel.h"

//
#import "SimpleNetworkEngineSingleton+RACSupport.h"
#import "SimpleNetworkEngineSingleton.h"
//
#import "SimpleToast.h"

//
#import "AppGetUserOrderFormListNetRequestBean.h"
#import "AppGetUserOrderFormListNetRespondBean.h"

//
#import "OrdersTableViewCellViewModel.h"

@interface OrdersViewModel () <SkyduckCEObservableMutableArrayRemoveDelegate>
// cell viewmodel list 里面存放 FavoritTableViewCellViewModel
@property (nonatomic, readwrite, strong) CEObservableMutableArray *cellViewModelList;
// 请求订单列表
@property (nonatomic, readwrite, strong) RACCommand *requestOrderListCommand;
// 立即支付
@property (nonatomic, readwrite, strong) RACCommand *payCommand;

@end
@implementation OrdersViewModel
- (id)init {
  if (self = [super init]) {
    [self initialize];
  }
  return self;
}

- (void) initialize {
  
  @weakify(self);
  self.cellViewModelList = [[CEObservableMutableArray alloc] init];
  self.cellViewModelList.delegateForRemoved = self;
  
  self.requestOrderListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    AppGetUserOrderFormListNetRequestBean *netRequestBean = [[AppGetUserOrderFormListNetRequestBean alloc] initWithPage:0 IsShowPay:YES isShowSupplier:YES];
    return [[SimpleNetworkEngineSingleton sharedInstance] signalForNetRequestDomainBean:netRequestBean];
  }];
  
  [[self.requestOrderListCommand execute:nil] subscribeNext:^(AppGetUserOrderFormListNetRespondBean *netRespondBean) {
    @strongify(self);
    
    // 构建数据源
//    for (id obj in favorListNetRespondBean.discountDetailList) {
//      FavoritTableViewCellViewModel *cellViewModel = [[FavoritTableViewCellViewModel alloc] initWithDiscountDetailModel:obj];
//      [self.cellViewModelList addObject:cellViewModel];
//    }
    
  }];
  
  // 点击事件
  self.payCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    NSLog(@"");
    return [RACSignal empty];
  }];
  
  
}

#pragma mark - SkyduckCEObservableMutableArrayRemoveDelegate
- (void)removedObject:(OrdersTableViewCellViewModel *)obj {
//  DeleteFavorNetRequestBean *netRequestBean = [[DeleteFavorNetRequestBean alloc] initWithID:obj.ID];
//  [[[SimpleNetworkEngineSingleton sharedInstance] signalForNetRequestDomainBean:netRequestBean] subscribeError:^(NSError *error) {
//    NSLog(@"%@", error.localizedDescription);
//  }];
}

@end