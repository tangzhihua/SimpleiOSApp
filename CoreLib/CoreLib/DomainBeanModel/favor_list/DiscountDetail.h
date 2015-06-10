
#import "BaseModel.h"
 
@interface DiscountDetail : BaseModel

//
@property (nonatomic, copy) NSString *ID;
// 折扣封图
@property (nonatomic, copy) NSString *pic;
// 折扣title
@property (nonatomic, copy) NSString *title;
// 折扣简介
@property (nonatomic, copy) NSString *detail;
// 折扣价格
@property (nonatomic, copy) NSString *price;
//
@property (nonatomic, assign) NSInteger booktype;
// 折扣到期时间
@property (nonatomic, copy) NSString *end_date;
//
@property (nonatomic, assign) long long firstpay_end_time;
//
@property (nonatomic, assign) long long start_time;
// 购买价格(当前价格)
@property (nonatomic, copy) NSString *buy_price;
// 初始价格(原价)
@property (nonatomic, copy) NSString *list_price;

// 是否穷游独享
@property (nonatomic, assign) BOOL self_use;
// 是否首发
@property (nonatomic, assign) BOOL first_pub;
// 是否穷游实验室认证1-是0-否
@property (nonatomic, assign) BOOL perperty_lab_auth;
// 是否今日新单1-是0-否
@property (nonatomic, assign) BOOL perperty_today_new;

// 折扣
@property (nonatomic, copy) NSString *lastminute_des;
//
@property (nonatomic, copy) NSString *url;
//
@property (nonatomic, copy) NSString *imgUrl;
//
@property (nonatomic, copy) NSString *type;
// 产品类型 代码
@property (nonatomic, copy) NSString *productType;
// 产品类型 英文描述
@property (nonatomic, copy) NSString *productTypeEngDesc;
//
@property (nonatomic, copy) NSString *departureTime;
//
@property (nonatomic, assign) NSInteger stock;
//
@property (nonatomic, assign) long long end_time;

@end
