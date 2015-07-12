//
//  OrdersTableViewCellViewModel.h
//  SimpleiOSApp
//
//  Created by skyduck on 15/7/7.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OrderInfo.h"

@interface OrdersTableViewCellViewModel : NSObject

@property (nonatomic, readonly, strong) OrderInfo *orderInfoModel;

/************************          预付款订单/余款订单          ************************/

@property (nonatomic, readonly, copy) NSString *orderTitle;// 订单标题
@property (nonatomic, readonly, copy) NSString *orderNumber;// 订单号
@property (nonatomic, readonly, copy) NSString *paymentType;// 付款类型
@property (nonatomic, readonly, copy) NSString *productType;// 产品类型
@property (nonatomic, readonly, copy) NSString *departureDate;// 出发日期
@property (nonatomic, readonly, copy) NSString *price;// 单价
@property (nonatomic, readonly, copy) NSString *productNumber;// 预定数量
@property (nonatomic, readonly, copy) NSNumber *singleRoomDifference;// 单房差
@property (nonatomic, readonly, copy) NSString *paymentTotal;// 支付总额

// 订单状态
@property (nonatomic, readonly, assign) OrderPaymemtTagEnum orderState;

/************************************************************************************/

- (instancetype)initWithOrderInfoModel:(OrderInfo *)orderInfoModel;
@end
