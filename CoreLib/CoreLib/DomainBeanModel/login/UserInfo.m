
#import "UserInfo.h"
#import "LoginDatabaseFieldsConstant.h"

static NSString *const kNSCodingField_uid       = @"uid";
static NSString *const kNSCodingField_userName  = @"userName";
static NSString *const kNSCodingField_email     = @"email";
static NSString *const kNSCodingField_gender    = @"gender";
static NSString *const kNSCodingField_bio       = @"bio";
static NSString *const kNSCodingField_lastVisit = @"lastVisit";
static NSString *const kNSCodingField_avatar    = @"avatar";
static NSString *const kNSCodingField_phone     = @"phone";

@interface UserInfo ()

@end

@implementation UserInfo

- (NSString *)description {
  return descriptionForDebug(self);
}


#pragma mark -
#pragma mark - 实现 NSCoding 接口

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_uid forKey:kNSCodingField_uid];
  [aCoder encodeObject:_userName forKey:kNSCodingField_userName];
  [aCoder encodeObject:_email forKey:kNSCodingField_email];
  [aCoder encodeInteger:_gender forKey:kNSCodingField_gender];
  [aCoder encodeObject:_bio forKey:kNSCodingField_bio];
  [aCoder encodeInteger:_lastVisit forKey:kNSCodingField_lastVisit];
  [aCoder encodeObject:_avatar forKey:kNSCodingField_avatar];
  [aCoder encodeObject:_phone forKey:kNSCodingField_phone];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super init])) {
    
    //
    if ([aDecoder containsValueForKey:kNSCodingField_uid]) {
      _uid = [aDecoder decodeObjectForKey:kNSCodingField_uid];
    }
    if ([aDecoder containsValueForKey:kNSCodingField_userName]) {
      _userName = [aDecoder decodeObjectForKey:kNSCodingField_userName];
    }
    if ([aDecoder containsValueForKey:kNSCodingField_email]) {
      _email = [aDecoder decodeObjectForKey:kNSCodingField_email];
    }
    //
    if ([aDecoder containsValueForKey:kNSCodingField_gender]) {
      _gender = [aDecoder decodeIntegerForKey:kNSCodingField_gender];
    }
    //
    if ([aDecoder containsValueForKey:kNSCodingField_bio]) {
      _bio = [aDecoder decodeObjectForKey:kNSCodingField_bio];
    }
    //
    if ([aDecoder containsValueForKey:kNSCodingField_lastVisit]) {
      _lastVisit = [aDecoder decodeIntegerForKey:kNSCodingField_lastVisit];
    }
    //
    if ([aDecoder containsValueForKey:kNSCodingField_avatar]) {
      _avatar = [aDecoder decodeObjectForKey:kNSCodingField_avatar];
    }
    //
    if ([aDecoder containsValueForKey:kNSCodingField_phone]) {
      _phone = [aDecoder decodeObjectForKey:kNSCodingField_phone];
    }
    
  }
  
  return self;
}
@end
