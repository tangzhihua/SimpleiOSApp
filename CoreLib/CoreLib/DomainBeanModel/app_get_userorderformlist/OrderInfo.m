 
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

#pragma mark -
#pragma mark - isEquual / hash "等同性"

// 这里借用 Eclipse 自动生成的isEqual算法
- (BOOL)isEqual:(id)obj{
  if (self == obj) {
    return YES;
  }
  if (obj == nil) {
    return NO;
  }
  if ([self class] != [obj class]) {
    return NO;
  }
  OrderInfo *other = (OrderInfo *) obj;
  if (![_orderId isEqualToString:other.orderId]) {
    return NO;
  }
  return YES;
}

// 这里借用 Eclipse 自动生成的hash算法
- (NSUInteger)hash {
  const NSUInteger prime = 31;
  NSUInteger result = 1;
  result = prime * result + (([NSString isEmpty:_orderId]) ? 0 : [_orderId hash]);
  return result;
}
@end
