 
#import "RegistDomainBeanHelper.h"

#import "RegistParseDomainBeanToDD.h"
#import "RegistNetRespondBean.h"

@implementation RegistDomainBeanHelper {
  id _parseNetRequestDomainBeanToDataDictionaryFunction;
}

/**
 * 将当前业务Bean, 解析成跟后台数据接口对应的数据字典
 * @return
 */
- (id<IParseNetRequestDomainBeanToDataDictionary>)parseNetRequestDomainBeanToDataDictionaryFunction {
  if (_parseNetRequestDomainBeanToDataDictionaryFunction == nil) {
    _parseNetRequestDomainBeanToDataDictionaryFunction = [[RegistParseDomainBeanToDD alloc] init];
  }
  return _parseNetRequestDomainBeanToDataDictionaryFunction;
}

/**
 * 当前业务Bean, 对应的URL地址.
 * @return
 */
- (NSString *)specialUrlPathWithNetRequestBean:(id)netRequestBean {
  return LastMinute_UrlConstant_SpecialPath_register;
}

/**
 * 当前网络响应业务Bean的Class
 * @return
 */
- (Class)netRespondBeanClass {
  return [RegistNetRespondBean class];
}

/**
 * 检查当前NetRespondBean是否有效
 * 这里的设计含义是 : 我们因为直接使用KVC, 将网络返回的数据字典直接解析成NetRespondBean, 但是这里有个隐患, 就是服务器返回的数据字典可能和本地的NetRespondBean字段不匹配, 所以每个NetRespondBean都应该设计有核心字段的概念, 只要服务器返回的数据字典包含有核心字典, 就认为本次数据有效,比如说登录接口,当登录成功后, 服务器会返回username和uid和其他一些字段, 那么uid和username就是核心字段, 只要这两个字段有效就可以认为本次网络请求有效
 * @return
 */
- (BOOL)isNetRespondBeanValidity:(in RegistNetRespondBean *)netRespondBean errorOUT:(out ErrorBean **)errorOUT {
  NSString *errorMessage = nil;
  do {
    if (netRespondBean.uid == nil) {
      errorMessage = @"服务器返回的数据 丢失关键字段 uid.";
      break;
    }
    
    if ([NSString isEmpty:netRespondBean.username]) {
      errorMessage = @"服务器返回的数据 丢失关键字段 username.";
      break;
    }
    
    if ([NSString isEmpty:netRespondBean.email]) {
      errorMessage = @"服务器返回的数据 丢失关键字段 email.";
      break;
    }
    
    return YES;
  } while (NO);
  
  if (errorOUT != NULL) {
    *errorOUT = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Server_KeyFieldLose errorMessage:errorMessage];
  }
  return NO;
}

/**
 * 考虑到后台不是同时都支持GET和POST请求, 而做的设计
 * @return GET/POST
 */
- (NSString *)httpMethod {
  return @"POST";
}
@end