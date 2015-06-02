
#import "LoginNetRespondBean.h"
#import "LoginDatabaseFieldsConstant.h"
#import "AccessToken.h"
#import "UserInfo.h"

static NSString *const kNSCodingField_AccessToken = @"AccessToken";
static NSString *const kNSCodingField_UserInfo    = @"UserInfo";


@interface LoginNetRespondBean ()

@end

@implementation LoginNetRespondBean

- (NSString *)description {
	return descriptionForDebug(self);
}


#pragma mark -
#pragma mark - 实现 NSCoding 接口

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_accessToken forKey:kNSCodingField_AccessToken];
  [aCoder encodeObject:_userInfo forKey:kNSCodingField_UserInfo];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super init])) {
    
    //
    if ([aDecoder containsValueForKey:kNSCodingField_AccessToken]) {
      _accessToken = [aDecoder decodeObjectForKey:kNSCodingField_AccessToken];
    }
    if ([aDecoder containsValueForKey:kNSCodingField_UserInfo]) {
      _userInfo = [aDecoder decodeObjectForKey:kNSCodingField_UserInfo];
    }
  }
  
  return self;
}
@end
