//
//  OrdersViewModel.h
//  SimpleiOSApp
//
//  Created by skyduck on 15/7/7.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CEObservableMutableArray.h"

@interface OrdersViewModel : NSObject
// cell viewmodel list 里面存放 FavoritTableViewCellViewModel
@property (nonatomic, readonly, strong) CEObservableMutableArray *cellViewModelList;
// 请求订单列表
@property (nonatomic, readonly, strong) RACCommand *requestOrderListCommand;
// 立即支付
@property (nonatomic, readonly, strong) RACCommand *payCommand;
@end
