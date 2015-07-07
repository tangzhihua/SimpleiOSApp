
#import <Foundation/Foundation.h>

@interface AppGetUserOrderFormListNetRequestBean : NSObject
// 页码
@property (nonatomic, assign, readonly) NSInteger page;
// 每页显示数量
@property (nonatomic, assign) NSInteger count;
// 是否显示支付类折扣1是0否
@property (nonatomic, assign, readonly) BOOL isShowPay;
// 0-不显示供应商创建折扣 1-显示供应商创建折扣，不传的话默认为0以兼容老版本
@property (nonatomic, assign, readonly) BOOL isShowSupplier;

#pragma mark -
#pragma mark - 构造方法
- (id)initWithPage:(NSInteger)page IsShowPay:(BOOL)isShowPay isShowSupplier:(BOOL)isShowSupplier;

- (id)init DEPRECATED_ATTRIBUTE;
@end
