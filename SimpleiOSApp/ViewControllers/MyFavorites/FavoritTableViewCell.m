//
//  CETweetTableViewCell.m
//  CETableViewBinding
//
//  Created by Colin Eberhardt on 28/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "FavoritTableViewCell.h"
#import "FavoritTableViewCellViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface FavoritTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;

@property (weak, nonatomic) IBOutlet UIButton *clickButton;

@end

@implementation FavoritTableViewCell

- (void)bindViewModel:(FavoritTableViewCellViewModel *)viewModel {
  self.titleLabel.text = viewModel.title;
  self.priceLabel.text = viewModel.price;
  self.endDateLabel.text = viewModel.endDate;
  
  @weakify(self);
  [[self.clickButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    @strongify(self);
    
    // 20150708 skyduck 如果设置了TabelView支持左滑删除的话, 那么当左滑时,
    // 会同时响应删除滑动事件和按钮的点击事件, 可以使用 isEditing 来进行判断.
    if (!self.isEditing) {
      [[self.selectionArray firstObject] execute:viewModel];
    }
    
  }];
  
  
 
}

- (BOOL)isOneselfHandleSelectionCommand {
  return YES;
}

 
@end
