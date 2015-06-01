

#import "ServerResponseDataValidityTest.h"
#import "ErrorBean.h"

@implementation ServerResponseDataValidityTest

#pragma mark 实现 IServerResponseDataValidityTest 接口
/**
 *  测试服务器返回的数据, 在业务上是否有效
 *
 *  @param serverResponseDataDictionary 数据字典
 *  @param errorOUT 如果业务上无效, 就通过这个参数回传外部调用者
 *
 *  @return YES : 业务上有效, NO : 业务上无效.
 */
- (BOOL)isServerResponseDataValid:(in NSDictionary *)serverResponseDataDictionary errorOUT:(out ErrorBean **)errorOUT {
  
  NSInteger errorCode = [serverResponseDataDictionary[@"retcode"] integerValue];
  NSString *errorMessage = serverResponseDataDictionary[@"retmsg"];
  
  if (errorCode != 0) {// 服务器端跟客户端商定, 错误码等于0时, 证明本次访问OK
    
    // 服务器端告知客户端, 本次请求发生错误.
    if (errorOUT != NULL) {
      *errorOUT = [ErrorBean errorBeanWithErrorCode:errorCode errorMessage:errorMessage];
    }
    return NO;
  } else {
    
    // 服务器告知客户端, 本次网络业务请求逻辑上有效
    return YES;
  }
}
@end
