
#import "AppGetUserOrderFormListNetRespondBean.h"
#import "AppGetUserOrderFormListDatabaseFieldsConstant.h"
#import "OrderInfo.h"

@interface AppGetUserOrderFormListNetRespondBean ()
//
@property (nonatomic, readwrite, strong) NSMutableArray *orderList;

@end
@implementation AppGetUserOrderFormListNetRespondBean

- (NSArray *)orderList {
  if (_orderList == nil) {
    _orderList = [[NSMutableArray alloc] init];
  }
  return _orderList;
}


#pragma mark -
#pragma mark - KVC
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  if ([key isEqualToString:@"data"]) {
    NSDictionary *dic = (NSDictionary *)value;
    for (NSString *key in dic.allKeys) {
      [self setValue:dic[key] forKey:key];
    }
  } else if ([key isEqualToString:@"res"]) {
    for (NSDictionary *record in value) {
      OrderInfo *orderInfo = [[OrderInfo alloc] initWithDictionary:record];
      [(NSMutableArray *)self.orderList addObject:orderInfo];
    }
  }
}

- (void)setValue:(id)value forKey:(NSString *)key {
  if ([key isEqualToString:@"server_time"]) {
    NSNumber *server_time = (NSNumber *)value;
    _server_time = [NSDate dateWithTimeIntervalSince1970:server_time.longLongValue];
  } else {
    [super setValue:value forKey:key];
  }
}
@end
