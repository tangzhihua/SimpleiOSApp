
#import "BaseModel.h"

//
@interface AccessToken : BaseModel

// token
@property (nonatomic, copy) NSString *access_token;
// 过期时间
@property (nonatomic, assign) NSInteger expires_in;
// 授权范围
@property (nonatomic, copy) NSString *scope;

@end
