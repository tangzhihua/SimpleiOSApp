//
//  OrdersTableViewCellViewModel.h
//  SimpleiOSApp
//
//  Created by skyduck on 15/7/7.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class OrderInfo;
@interface OrdersTableViewCellViewModel : NSObject
// 收藏 ID
@property (nonatomic, readonly, copy) NSNumber *orderId;
// =============预付款订单===============
@property (nonatomic, readonly, copy) NSString *tv_order_title;
@property (nonatomic, readonly, copy) NSString *tv_order_no;
@property (nonatomic, readonly, copy) NSString *tv_order_pay_type;
@property (nonatomic, readonly, copy) NSString *tv_order_product_type;
@property (nonatomic, readonly, copy) NSString *tv_order_departure_date;
@property (nonatomic, readonly, copy) NSString *tv_order_product_price;
@property (nonatomic, readonly, copy) NSString *tv_order_pay_num;
@property (nonatomic, readonly, copy) NSString *tv_order_single_room;
//LinearLayout layout_order_single_room;
@property (nonatomic, readonly, copy) NSString *tv_order_pay_total;
// 全款支付成功 or 预付款支付成功 or 订单支付时间已过 产品已经售罄 or 订单时间已过 你可以重新购买
//RelativeLayout rl_order_pay_status;
@property (nonatomic, readonly, strong) UIImage *iv_pay_status;
@property (nonatomic, readonly, copy) NSString *tv_pay_status;
// 预付款支付已经成功，你还有xx时间支付余款
//RelativeLayout rl_order_notifi;
@property (nonatomic, readonly, copy) NSString *tv_order_pay_ok;
@property (nonatomic, readonly, copy) NSString *tv_order_pay_time;
//View line2;
//Button bt_order;// 重新购买，立即支付，通知我
// ============new add for 重新购买====================
//RelativeLayout rl_order_pay_status0;

// =============余款订单===============
//LinearLayout relativeLayout2; // 余款面板
@property (nonatomic, readonly, copy) NSString *tv_order_title2;
@property (nonatomic, readonly, copy) NSString *tv_order_no2;
@property (nonatomic, readonly, copy) NSString *tv_order_pay_type2;
@property (nonatomic, readonly, copy) NSString *tv_order_product_type2;
@property (nonatomic, readonly, copy) NSString *tv_order_departure_date2;
@property (nonatomic, readonly, copy) NSString *tv_order_product_price2;
@property (nonatomic, readonly, copy) NSString *tv_order_pay_num2;
@property (nonatomic, readonly, copy) NSString *tv_order_single_room2;
//LinearLayout layout_order_single_room2;
@property (nonatomic, readonly, copy) NSString *tv_order_pay_total2;
// 全款支付成功 or 预付款支付成功 or 订单支付时间已过 产品已经售罄 or 订单时间已过 你可以重新购买
//RelativeLayout rl_order_pay_status2;
@property (nonatomic, readonly, strong) UIImage *iv_pay_status2;
@property (nonatomic, readonly, copy) NSString *tv_pay_status2;
// 预付款支付已经成功，你还有xx时间支付余款
//RelativeLayout rl_order_notifi2;
@property (nonatomic, readonly, copy) NSString *tv_order_pay_ok2;
@property (nonatomic, readonly, copy) NSString *tv_order_pay_time2;
//Button bt_order2;// 重新购买，立即支付，通知我

- (instancetype)initWithOrderInfoModel:(OrderInfo *)orderInfoModel;
@end
