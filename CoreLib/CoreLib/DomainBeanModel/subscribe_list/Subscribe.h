
#import "BaseModel.h"
 
@interface Subscribe : BaseModel

//
@property (nonatomic, copy) NSString *subscribeId;
// 折扣类型
@property (nonatomic, copy) NSString *productType;
// 旅行时间
@property (nonatomic, copy) NSString *date;
// 目的地
@property (nonatomic, copy) NSString *country;
// 出发地
@property (nonatomic, copy) NSString *start_pos;

@end
