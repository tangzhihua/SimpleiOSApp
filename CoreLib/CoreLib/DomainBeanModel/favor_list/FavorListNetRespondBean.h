
#import "BaseModel.h"

@class DiscountDetail;
@interface FavorListNetRespondBean : BaseModel

// 我的收藏列表
@property (nonatomic, readonly, strong) NSArray *discountDetailList;


@end
