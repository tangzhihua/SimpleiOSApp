
#import "AppGetUserOrderFormListParseDomainBeanToDD.h"

#import "AppGetUserOrderFormListDatabaseFieldsConstant.h"
#import "AppGetUserOrderFormListNetRequestBean.h"

@implementation AppGetUserOrderFormListParseDomainBeanToDD
/**
 *  将一个 "网络请求业务Bean" 解析成发往服务器的 "数据字典", 在这里设置的Key, 是跟服务器约定好的
 *
 *  @param netRequestDomainBean 网络请求业务Bean
 *  @param error                如果出现错误, 就通过这个error参数传递出去, 错误的原因可能用户传入的 netRequestDomainBean 无效
 *
 *  @return "发往服务器的数据字典"
 */
- (NSDictionary *)parseNetRequestDomainBeanToDataDictionary:(in AppGetUserOrderFormListNetRequestBean *)netRequestBean error:(out ErrorBean **)errorOUT {
  
  NSString *errorMessage = nil;
  do {
    if (![netRequestBean isMemberOfClass:[AppGetUserOrderFormListNetRequestBean class]]) {
      errorMessage = @"传入的业务Bean的类型不符 !";
      break;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //
    params[LastMinute_AppGetUserOrderFormList_RequestKey_page] = @(netRequestBean.page);
    //
    params[LastMinute_AppGetUserOrderFormList_RequestKey_count] = @(netRequestBean.count);
    
    // 是否显示支付类折扣1是0否
    NSNumber *isShowPay = [NSNumber numberWithInt:netRequestBean.isShowPay?1:0];
    params[LastMinute_AppGetUserOrderFormList_RequestKey_is_show_pay] = isShowPay;
    // 0-不显示供应商创建折扣 1-显示供应商创建折扣，不传的话默认为0以兼容老版本
    NSNumber *isShowSupplier = [NSNumber numberWithInt:netRequestBean.isShowSupplier?1:0];
    params[LastMinute_AppGetUserOrderFormList_RequestKey_is_show_supplier] = isShowSupplier;
    
    
    
        // 通知外部, 一切OK
    if (errorOUT != NULL) {
      *errorOUT = nil;
    }
    return params;
  } while (NO);
  
  // 通知外部, 发生了错误
  if (errorOUT != NULL) {
    *errorOUT = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Client_NetRequestBeanInvalid errorMessage:errorMessage];
  }
  return nil;
}
@end