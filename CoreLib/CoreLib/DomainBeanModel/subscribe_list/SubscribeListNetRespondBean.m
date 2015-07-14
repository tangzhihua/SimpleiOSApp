
#import "SubscribeListNetRespondBean.h"
#import "SubscribeListDatabaseFieldsConstant.h"
#import "Subscribe.h"


@implementation SubscribeListNetRespondBean

- (NSArray *)subscribeList{
  if (_subscribeList == nil) {
    _subscribeList = [[NSMutableArray alloc] init];
  }
  return _subscribeList;
}


#pragma mark -
#pragma mark - KVC
- (void)setValue:(id)value forKey:(NSString *)key {
  if ([key isEqualToString:@"data"]) {
    // 有多个数据
    for (NSDictionary *record in value) {
      Subscribe *subscribe = [[Subscribe alloc] initWithDictionary:record];
      [(NSMutableArray *)self.subscribeList addObject:subscribe];
    }
 
  } else {
    [super setValue:value forKey:key];
  }
}


@end
