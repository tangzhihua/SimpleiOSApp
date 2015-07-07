//
//  FavoritesViewModel.h
//  SimpleiOSApp
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

@property (nonatomic, readonly, strong) RACCommand *requestFavorListCommand;

@property (nonatomic, readonly, strong) RACCommand *favorListViewSelectedCommand;

@end
