//
//  FavoritesViewModel.m
//  SimpleiOSApp
//
//  Created by skyduck on 15/7/1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import "FavoritesViewModel.h"

//
#import "SimpleNetworkEngineSingleton+RACSupport.h"
#import "SimpleNetworkEngineSingleton.h"
//
#import "SimpleToast.h"

//
#import "FavorListNetRequestBean.h"
#import "FavorListNetRespondBean.h"

//
#import "DeleteFavorNetRequestBean.h"
#import "DeleteFavorNetRespondBean.h"

//
#import "FavoritTableViewCellViewModel.h"



@interface FavoritesViewModel () <SkyduckCEObservableMutableArrayRemoveDelegate>
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
  self.cellViewModelList.delegateForRemoved = self;
  
  self.requestFavorListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    FavorListNetRequestBean *netRequestBean = [[FavorListNetRequestBean alloc] initWithIsShowPay:YES isShowSupplier:YES];
    return [[SimpleNetworkEngineSingleton sharedInstance] signalForNetRequestDomainBean:netRequestBean];
  }];
  
  [[self.requestFavorListCommand execute:nil] subscribeNext:^(FavorListNetRespondBean *favorListNetRespondBean) {
    @strongify(self);

    // 构建数据源
    for (id obj in favorListNetRespondBean.discountDetailList) {
      FavoritTableViewCellViewModel *cellViewModel = [[FavoritTableViewCellViewModel alloc] initWithDiscountDetailModel:obj];
      [self.cellViewModelList addObject:cellViewModel];
    }

  }];
  
  // 点击事件
  self.favorListViewSelectedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    NSLog(@"");
    return [RACSignal empty];
  }];
  

}

#pragma mark - SkyduckCEObservableMutableArrayRemoveDelegate
- (void)removedObject:(FavoritTableViewCellViewModel *)obj {
  DeleteFavorNetRequestBean *netRequestBean = [[DeleteFavorNetRequestBean alloc] initWithID:obj.ID];
  [[[SimpleNetworkEngineSingleton sharedInstance] signalForNetRequestDomainBean:netRequestBean] subscribeError:^(NSError *error) {
    NSLog(@"%@", error.localizedDescription);
  }];
}
@end
