//
//  OrderInfo.h
//  CoreLib
//
//  Created by skyduck on 15/7/7.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import "BaseModel.h"

/** 订单支付状态 1 已支付 0未支付 -1超时 **/
typedef NS_ENUM(NSInteger, OrderPaymemtTagEnum) {
  
  OrderPaymemtTagEnum_NONE = -2, // 无效状态
  
  OrderPaymemtTagEnum_Timeout = -1,// 超时
  
  OrderPaymemtTagEnum_Unpaid = 0,// 未支付
  
  OrderPaymemtTagEnum_Paid = 1,// 已支付
};

/** 产品类型 0为全款 1为预付款 2为尾款 */
typedef NS_ENUM(NSInteger, ProductTypeTagEnum) {
  
  ProductTypeTagEnum_NONE = -1, // 无效状态
  
  ProductTypeTagEnum_All = 0,// 全款
  
  ProductTypeTagEnum_Header = 1,// 预付款
  
  ProductTypeTagEnum_Footer = 2,// 余款
};

/** 商家类型： 1 非认证商家 2 认证商家 */
typedef NS_ENUM(NSInteger, SupplierTypeTagEnum) {
  
  SupplierTypeTagEnum_NONE = -1, // 无效状态
  
  SupplierTypeTagEnum_Unauthen = 1,// 非认证商家
  
  SupplierTypeTagEnum_Authen = 2,// 认证商家
 
};

/** 支付方式：0 未支付 1 web端支付 2 app端支付(支付宝钱包) */
typedef NS_ENUM(NSInteger, PayTypeTagEnum) {
  
  PayTypeTagEnum_NONE = -1, // 无效状态
  
  PayTypeTagEnum_Unpaid = 0,// 未支付
  
  PayTypeTagEnum_Web = 1,// 支付宝
  
  PayTypeTagEnum_Client = 2,// 支付宝钱包
  
};

@interface OrderInfo : BaseModel

/** 订单ID & 订单号 **/
@property (nonatomic, copy) NSString *orderId;
/** 购买数量 **/
@property (nonatomic, copy) NSString *num;
/** name **/
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
/** 购买单价 float **/
@property (nonatomic, copy) NSString *unit_price;
/** 购买总价 float **/
@property (nonatomic, copy) NSString *price;
/** 1 已支付 0未支付 -1超时 **/
@property (nonatomic, assign) OrderPaymemtTagEnum payment;
/** lastminute 商品id **/
@property (nonatomic, copy) NSString *lastminute_id;
/** 截止时间，为0时则表示不限制 */
@property (nonatomic, copy) NSString *lastalipaydatetime;
/** 折扣标题 */
@property (nonatomic, copy) NSString *lastminute_title;
/** 折扣价格 可能为数字，也可能为<em>999</em>元起 */
@property (nonatomic, copy) NSString *lastminute_price;
/** 产品类型 0为全款 1为预付款 2为尾款 */
@property (nonatomic, assign) ProductTypeTagEnum products_type;
/** 产品标题 */
@property (nonatomic, copy) NSString *products_title;
/** 出发日期 */
@property (nonatomic, copy) NSString *products_departure_date;
/** 商家名称 */
@property (nonatomic, copy) NSString *supplier_title;
/** 商家类型 1，非认证商家 2，认证商家 */
@property (nonatomic, assign) SupplierTypeTagEnum supplier_type;
/** 商家电话 */
@property (nonatomic, copy) NSString *supplier_phone;

// ===========余款订单 信息=======================
@property (nonatomic, strong) OrderInfo *balance_order;
/** 余款开始时间戳 */
@property (nonatomic, copy) NSString *secondpay_start_time;
/** 余款结束时间戳 */
@property (nonatomic, copy) NSString *secondpay_end_time;
/** 库存 */
@property (nonatomic, assign) NSInteger stock; // 库存
/** 0 未支付 1 web端支付 2 app端支付 */
@property (nonatomic, assign) PayTypeTagEnum payType;
/** 折扣图片 */
@property (nonatomic, copy) NSString *lastminute_pic;
/** 支付成功时间 */
@property (nonatomic, copy) NSString *return_time;
/** 只要第一次支付时间，没有过期，就可以继续购买 */
@property (nonatomic, copy) NSString *firstpay_end_time;
/** 商家支付宝号 */
@property (nonatomic, copy) NSString *alipay_account;
/**
 * 设置未付款交易的超时时间, 一旦超时,该笔交易就会自动 被关闭。 取值范围:1m~15d。 m-分钟,h-小时,d-天, 1c-
 * 当天(无论交易何时创建,都 在 0 点关闭)。 该参数数值不接受小数点,如 1.5h,可转换为 90m。 该功能需要联系支付宝配置 关闭时间。
 */
@property (nonatomic, copy) NSString *itBPayTime;
/** 单房差总额，如果没有，则返回"0" */
@property (nonatomic, copy) NSNumber *room_price_total;
/** 支付宝传参 */
@property (nonatomic, copy) NSString *qyer_des;

@end
