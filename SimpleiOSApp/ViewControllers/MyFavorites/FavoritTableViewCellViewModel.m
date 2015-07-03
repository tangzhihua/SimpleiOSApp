//
//  FavoritTableViewCellViewModel.m
//  SimpleiOSApp
//
//  Created by skyduck on 15/7/1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import "FavoritTableViewCellViewModel.h"

#import "DiscountDetail.h"

@implementation FavoritTableViewCellViewModel
- (instancetype)initWithDiscountDetailModel:(DiscountDetail *)discountDetailModel {
  if ((self = [super init])) {
    _title = [discountDetailModel.title copy];
    _price = [discountDetailModel.price copy];
    _endDate = [discountDetailModel.end_date copy];
  }
  
  return self;
}
@end