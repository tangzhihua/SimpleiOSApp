
#import "Subscribe.h"
#import "SubscribeListDatabaseFieldsConstant.h"

@implementation Subscribe


#pragma mark - NSKeyValueCoding
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  if ([key isEqualToString:LastMinute_SubscribeList_RespondKey_subscribeId]) {
    _subscribeId = value;
  }
}



@end
