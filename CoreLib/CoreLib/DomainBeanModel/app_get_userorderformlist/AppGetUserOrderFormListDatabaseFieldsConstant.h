

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
#define LastMinute_AppGetUserOrderFormList_RespondKey_counts @"counts"
//
#define LastMinute_AppGetUserOrderFormList_RespondKey_res @"res"
//
#define LastMinute_AppGetUserOrderFormList_RespondKey_server_time @"server_time"
#endif
