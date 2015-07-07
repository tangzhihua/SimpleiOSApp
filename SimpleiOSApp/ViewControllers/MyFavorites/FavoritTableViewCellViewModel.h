//
//  FavoritTableViewCellViewModel.h
//  SimpleiOSApp
//
//  Created by skyduck on 15/7/1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>
 
@class DiscountDetail;
@interface FavoritTableViewCellViewModel : NSObject

@property (nonatomic, readonly, copy) NSNumber *ID;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *price;
@property (nonatomic, readonly, copy) NSString *endDate;

- (instancetype)initWithDiscountDetailModel:(DiscountDetail *)discountDetailModel;
@end