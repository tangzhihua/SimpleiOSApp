
#import "DomainBeanRequestPublicParams.h"
#import "ErrorCodeEnum.h"
#import "ErrorBean.h"

#import "LoginManager.h"
#import "LoginNetRespondBean.h"
#import "AccessToken.h"
#import "UserInfo.h"

@implementation DomainBeanRequestPublicParams
- (NSDictionary *)publicParamsWithErrorOUT:(ErrorBean **)errorOUT {
  NSString *errorMessage = nil;
  do {
    NSMutableDictionary *publicParams = [NSMutableDictionary dictionaryWithCapacity:10];
    
    publicParams[@"client_id"] = @"qyer_discount_androi";
    publicParams[@"client_secret"] = @"227097da1d07a2a9860f";
    
    publicParams[@"v"] = @"1";
    publicParams[@"track_deviceid"] = @"355867057826607";
    publicParams[@"track_app_version"] = @"1.6.3";
    publicParams[@"track_app_channel"] = @"UMENG_CHANNEL_VALUE";
    publicParams[@"track_device_info"] = @"m7cdtu";
    publicParams[@"track_os"] = @"Android4.2.2";
    if ([LoginManager sharedInstance].latestLoginNetRespondBean != nil) {
      publicParams[@"track_user_id"] = [LoginManager sharedInstance].latestLoginNetRespondBean.userInfo.uid;
      publicParams[@"oauth_token"] = [LoginManager sharedInstance].latestLoginNetRespondBean.accessToken.access_token;
    }
    
    publicParams[@"app_installtime"] = @"1433163722985";
    
    return publicParams;
  } while (NO);
  
  if (errorOUT != NULL) {
    *errorOUT = [ErrorBean errorBeanWithErrorCode:ErrorCodeEnum_Client_IllegalArgument errorMessage:errorMessage];
  }
  return nil;
}
@end
