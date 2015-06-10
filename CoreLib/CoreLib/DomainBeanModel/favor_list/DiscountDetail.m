
#import "DiscountDetail.h"
#import "FavorListDatabaseFieldsConstant.h"

@implementation DiscountDetail


#pragma mark - NSKeyValueCoding
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  if ([key isEqualToString:LastMinute_FavorList_RespondKey_id]) {
    _ID = value;
  }
}



@end
