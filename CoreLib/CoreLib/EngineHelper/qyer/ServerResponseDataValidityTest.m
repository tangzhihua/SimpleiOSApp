

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
  
  id status = serverResponseDataDictionary[@"status"];
  if (status != nil) {
    NSInteger errorCode = [serverResponseDataDictionary[@"status"] integerValue];
    NSString *errorMessage = serverResponseDataDictionary[@"info"];
    
    // 服务器端告知客户端, 本次请求发生错误.
    if (errorOUT != NULL) {
      *errorOUT = [ErrorBean errorBeanWithErrorCode:errorCode errorMessage:errorMessage];
    }
    return NO;
  }
  
  // 服务器告知客户端, 本次网络业务请求逻辑上有效
  return YES;
}
@end
