
#import "DeleteSubscribeParseDomainBeanToDD.h"

#import "DeleteSubscribeDatabaseFieldsConstant.h"
#import "DeleteSubscribeNetRequestBean.h"

@implementation DeleteSubscribeParseDomainBeanToDD
/**
 *  将一个 "网络请求业务Bean" 解析成发往服务器的 "数据字典", 在这里设置的Key, 是跟服务器约定好的
 *
 *  @param netRequestDomainBean 网络请求业务Bean
 *  @param error                如果出现错误, 就通过这个error参数传递出去, 错误的原因可能用户传入的 netRequestDomainBean 无效
 *
 *  @return "发往服务器的数据字典"
 */
- (NSDictionary *)parseNetRequestDomainBeanToDataDictionary:(in DeleteSubscribeNetRequestBean *)netRequestDomainBean error:(out ErrorBean **)errorOUT {
  
  NSString *errorMessage = nil;
  do {
    if (![netRequestDomainBean isMemberOfClass:[DeleteSubscribeNetRequestBean class]]) {
      errorMessage = @"传入的业务Bean的类型不符 !";
      break;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    if ([NSString isEmpty:netRequestDomainBean.subscribeId]) {
      errorMessage = @"丢失关键参数 : subscribeId";
      break;
    }
    params[LastMinute_DeleteSubscribe_RequestKey_id] = netRequestDomainBean.subscribeId;
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