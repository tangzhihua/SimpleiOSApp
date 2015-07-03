//
//  FavoritesViewModel.m
//  SimpleiOSApp
//
//  Created by skyduck on 15/7/1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import "FavoritesViewModel.h"
#import "FavorListNetRespondBean.h"
#import "SimpleNetworkEngineSingleton+RACSupport.h"
#import "SimpleNetworkEngineSingleton.h"
#import "FavorListNetRequestBean.h"
#import "FavorListNetRespondBean.h"
#import "SimpleToast.h"
#import "FavoritTableViewCellViewModel.h"


@interface FavoritesViewModel () <CEObservableMutableArrayDelegate>
@property (nonatomic, readwrite, strong) CEObservableMutableArray *cellViewModelList;
@property (nonatomic, readwrite, strong) RACCommand *requestFavorListCommand;

@property (nonatomic, readwrite, strong) RACCommand *favorListViewSelectedCommand;
@end
@implementation FavoritesViewModel
- (id)init {
  if (self = [super init]) {
    [self initialize];
  }
  return self;
}

- (void) initialize {
  
  @weakify(self);
  self.cellViewModelList = [[CEObservableMutableArray alloc] init];
  
  
  self.requestFavorListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    FavorListNetRequestBean *netRequestBean = [[FavorListNetRequestBean alloc] initWithIsShowPay:YES isShowSupplier:YES];
    return [[SimpleNetworkEngineSingleton sharedInstance] signalForNetRequestDomainBean:netRequestBean];
  }];
  
  [[self.requestFavorListCommand execute:nil] subscribeNext:^(FavorListNetRespondBean *favorListNetRespondBean) {
    @strongify(self);
    for (id obj in favorListNetRespondBean.discountDetailList) {
      FavoritTableViewCellViewModel *cellViewModel = [[FavoritTableViewCellViewModel alloc] initWithDiscountDetailModel:obj];
      [self.cellViewModelList addObject:cellViewModel];
    }
    
    // 注意 : CEObservableMutableArray->delegate 会在调用
    // CETableViewBindingHelper bindingHelperForTableView 时被设置成nil
    // 所以要注意, 最好使用时设置
    self.cellViewModelList.delegate = self;
  }];
  
}

#pragma mark - CEObservableMutableArrayDelegate
/// invoked when an item is removed from the aray
- (void)array:(CEObservableMutableArray *)array didRemoveItemAtIndex:(NSUInteger) index {
  
}
@end
