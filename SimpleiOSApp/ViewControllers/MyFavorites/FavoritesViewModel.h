//
//  FavoritesViewModel.h
//  对应 FavoritesViewController 的 ViewModel
//
//  Created by skyduck on 15/7/1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CEObservableMutableArray.h"

@interface FavoritesViewModel : NSObject

// cell viewmodel list 里面存放 FavoritTableViewCellViewModel
@property (nonatomic, readonly, strong) CEObservableMutableArray *cellViewModelList;
// 请求收藏列表
@property (nonatomic, readonly, strong) RACCommand *requestFavorListCommand;
// 点击收藏记录
@property (nonatomic, readonly, strong) RACCommand *favorListViewSelectedCommand;

@end
