
#import "FavorListNetRespondBean.h"
#import "FavorListDatabaseFieldsConstant.h"
#import "DiscountDetail.h"

@interface FavorListNetRespondBean ()
//
@property (nonatomic, readwrite, strong) NSMutableArray *discountDetailList;

@end
@implementation FavorListNetRespondBean

- (NSArray *)discountDetailList{
  if (_discountDetailList == nil) {
    _discountDetailList = [[NSMutableArray alloc] init];
  }
  return _discountDetailList;
}


#pragma mark -
#pragma mark - KVC
- (void)setValue:(id)value forKey:(NSString *)key {
  if ([key isEqualToString:@"data"]) {
    // 有多个数据
    for (NSDictionary *record in value) {
      DiscountDetail *discountDetail = [[DiscountDetail alloc] initWithDictionary:record];
      [(NSMutableArray *)self.discountDetailList addObject:discountDetail];
    }
 
  } else {
    [super setValue:value forKey:key];
  }
}


@end
