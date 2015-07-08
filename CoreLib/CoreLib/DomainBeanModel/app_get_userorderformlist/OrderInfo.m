 
#import "OrderInfo.h"

@implementation OrderInfo
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  if ([key isEqualToString:@"lastminute"]) {
    NSDictionary *dic = (NSDictionary *)value;
    self.lastminute_id = dic[@"id"];
    self.firstpay_end_time = dic[@"firstpay_end_time"];
  } else if ([key isEqualToString:@"id"]) {
    self.orderId = value;
  }
}
@end
