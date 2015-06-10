
#import "AccessToken.h"
#import "LoginDatabaseFieldsConstant.h"

static NSString *const kNSCodingField_access_token = @"access_token";
static NSString *const kNSCodingField_expires_in   = @"expires_in";
static NSString *const kNSCodingField_scope        = @"scope";

@interface AccessToken ()

@end

@implementation AccessToken

#pragma mark -
#pragma mark - 实现 NSCoding 接口

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_access_token forKey:kNSCodingField_access_token];
  [aCoder encodeInteger:_expires_in forKey:kNSCodingField_expires_in];
  [aCoder encodeObject:_scope forKey:kNSCodingField_scope];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super init])) {
    
    //
    if ([aDecoder containsValueForKey:kNSCodingField_access_token]) {
      _access_token = [aDecoder decodeObjectForKey:kNSCodingField_access_token];
    }
    if ([aDecoder containsValueForKey:kNSCodingField_expires_in]) {
      _expires_in = [aDecoder decodeIntegerForKey:kNSCodingField_expires_in];
    }
    //
    if ([aDecoder containsValueForKey:kNSCodingField_scope]) {
      _scope = [aDecoder decodeObjectForKey:kNSCodingField_scope];
    }
    
  }
  
  return self;
}
@end
