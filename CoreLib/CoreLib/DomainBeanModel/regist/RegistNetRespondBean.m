
#import "RegistNetRespondBean.h"

@implementation RegistNetRespondBean
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  if ([key isEqualToString:@"data"]) {
    NSDictionary *dic = (NSDictionary *)value;
    for (NSString *key in dic.allKeys) {
      [self setValue:dic[key] forKey:key];
    }
  }
}
@end
