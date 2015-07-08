

#ifndef LastMinute_AppGetUserOrderFormListDatabaseFieldsConstant_h
#define LastMinute_AppGetUserOrderFormListDatabaseFieldsConstant_h

/************      RequestBean       *************/


//
#define LastMinute_AppGetUserOrderFormList_RequestKey_page @"page"
//
#define LastMinute_AppGetUserOrderFormList_RequestKey_count @"count"
// 是否显示支付类折扣1是0否
#define LastMinute_AppGetUserOrderFormList_RequestKey_is_show_pay @"is_show_pay"
// 0-不显示供应商创建折扣 1-显示供应商创建折扣，不传的话默认为0以兼容老版本
#define LastMinute_AppGetUserOrderFormList_RequestKey_is_show_supplier @"is_show_supplier"



/************      RespondBean       *************/

//
#define LastMinute_AppGetUserOrderFormList_RespondKey_server_time @"server_time"

#define LastMinute_AppGetUserOrderFormList_RespondKey_id @"id"
#define LastMinute_AppGetUserOrderFormList_RespondKey_pid @"pid"
#define LastMinute_AppGetUserOrderFormList_RespondKey_num @"num"
#define LastMinute_AppGetUserOrderFormList_RespondKey_name @"name"
#define LastMinute_AppGetUserOrderFormList_RespondKey_phone @"phone"

#define LastMinute_AppGetUserOrderFormList_RespondKey_email @"email"
#define LastMinute_AppGetUserOrderFormList_RespondKey_uid @"uid"
/** 单价 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_unit_price @"unit_price"
/** 总价 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_price @"price"
// 订单状态 1 已支付 0未支付 -1超时
#define LastMinute_AppGetUserOrderFormList_RespondKey_payment @"payment"
/** 支付时间 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_datetime @"datetime"
/** 1首次付款 2二次付款 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_firstpay @"firstpay"
// ===========new add===============
/** 截止时间，为0时则表示不限制 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_lastalipaydatetime @"lastalipaydatetime"
/** 折扣标题 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_lastminute_title @"lastminute_title"
/** 折扣价格 可能为数字，也可能为<em>999</em>元起 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_lastminute_price @"lastminute_price"
/** 产品类型 0为全款 1为预付款 2为尾款 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_products_type @"products_type"
/** 产品标题 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_products_title @"products_title"
/** 出发日期 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_products_departure_date @"products_departure_date"
/** 商家支付宝号 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_alipay_account @"alipay_account"
/** 商家名称 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_supplier_title @"supplier_title"
/** 商家类型 1，非认证商家 0，认证商家 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_supplier_type @"supplier_type"
/** 商家电话 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_supplier_phone @"supplier_phone"
/** lastminute id<父一级lastminute> **/
#define LastMinute_AppGetUserOrderFormList_RespondKey_lastminute_id @"id"

// ===================new add for get list_orders=========
/** 总数目 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_counts @"counts"
/** array list */
#define LastMinute_AppGetUserOrderFormList_RespondKey_res @"res"
/** 折扣 信息<信息在子一级别里> */
#define LastMinute_AppGetUserOrderFormList_RespondKey_lastminute @"lastminute"
/** 供应商 信息<信息在子一级别里> */
#define LastMinute_AppGetUserOrderFormList_RespondKey_supplier @"supplier"
/** 产品 信息<信息在子一级别里> */
#define LastMinute_AppGetUserOrderFormList_RespondKey_products @"products"
/** products库存<父一级是“products”> */
#define LastMinute_AppGetUserOrderFormList_RespondKey_stock @"stock"
/** 订单 信息<信息在子一级别里> */
#define LastMinute_AppGetUserOrderFormList_RespondKey_orderform @"orderform"
/** 尾款订单<信息在子一级别里> */
#define LastMinute_AppGetUserOrderFormList_RespondKey_balanceorder @"balanceorder"
/** 余款单开始时间 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_secondpay_start_time @"secondpay_start_time"
/** 余款单结束时间 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_secondpay_end_time @"secondpay_end_time"
/** relid 关系id */
#define LastMinute_AppGetUserOrderFormList_RespondKey_relid @"relid"
/** 支付成功时间 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_return_time @"return_time"
/** 第一次支付的结束时间 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_firstpay_end_time @"firstpay_end_time"
/** 单房差总额 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_room_price_total @"room_price_total"
/** 支付宝传参 */
#define LastMinute_AppGetUserOrderFormList_RespondKey_qyer_des @"qyer_des"

#endif
