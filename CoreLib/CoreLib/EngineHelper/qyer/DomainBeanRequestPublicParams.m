
#import "DomainBeanRequestPublicParams.h"
#import "ErrorCodeEnum.h"
#import "ErrorBean.h"

@implementation DomainBeanRequestPublicParams
- (NSDictionary *)publicParamsWithErrorOUT:(ErrorBean **)errorOUT {
  NSString *errorMessage = nil;
  do {
    NSMutableDictionary *publicParams = [NSMutableDictionary dictionaryWithCapacity:10];
    
 
    publicParams[@"pid"] = nil;
    
    return publicParams;
  } while (NO);
  
  if (errorOUT != NULL) {
    *errorOUT = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Client_IllegalArgument errorMessage:errorMessage];
  }
  return nil;
}
@end
