
#import "BaseModel.h"

@interface AppGetUserOrderFormListNetRespondBean : BaseModel

@property (nonatomic, assign) NSInteger counts;
@property (nonatomic, readonly, strong) NSDate *server_time;

// 我的订单列表
@property (nonatomic, readonly, strong) NSArray *orderList;
@end
