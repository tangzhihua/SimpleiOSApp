
#import "LoginNetRespondBean.h"
#import "LoginDatabaseFieldsConstant.h"
#import "AccessToken.h"
#import "UserInfo.h"

static NSString *const kNSCodingField_AccessToken = @"AccessToken";
static NSString *const kNSCodingField_UserInfo    = @"UserInfo";


@interface LoginNetRespondBean ()

@end

@implementation LoginNetRespondBean

- (AccessToken *)accessToken {
  if (_accessToken == nil) {
    _accessToken = [[AccessToken alloc] init];
  }
  
  return _accessToken;
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

#pragma mark -
#pragma mark - KVC
- (void)setValue:(id)value forKey:(NSString *)key {
  if ([key isEqualToString:LastMinute_Login_RespondKey_access_token]) {
    self.accessToken.access_token = value;
  } else if ([key isEqualToString:LastMinute_Login_RespondKey_expires_in]) {
    self.accessToken.expires_in = [value integerValue];
  } else if ([key isEqualToString:LastMinute_Login_RespondKey_scope]) {
    self.accessToken.scope = value;
  } else if ([key isEqualToString:LastMinute_Login_RespondKey_user_info]) {
    _userInfo = [[UserInfo alloc] initWithDictionary:value];
  } else {
    [super setValue:value forKey:key];
  }
}


@end
