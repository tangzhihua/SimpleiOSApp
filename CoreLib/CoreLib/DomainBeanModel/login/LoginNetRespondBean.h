
#import "BaseModel.h"

@class AccessToken;
@class UserInfo;
@interface LoginNetRespondBean : BaseModel

// 登录名
@property (nonatomic, strong) AccessToken *accessToken;
// 登录密码
@property (nonatomic, strong) UserInfo *userInfo;

@end
