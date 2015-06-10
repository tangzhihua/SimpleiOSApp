
#import <Foundation/Foundation.h>

@interface FavorListNetRequestBean : NSObject
// 是否显示支付类折扣1是0否
@property (nonatomic, assign, readonly) BOOL isShowPay;
// 0-不显示供应商创建折扣 1-显示供应商创建折扣，不传的话默认为0以兼容老版本
@property (nonatomic, assign, readonly) BOOL isShowSupplier;

#pragma mark -
#pragma mark - 构造方法
- (id)initWithIsShowPay:(BOOL)isShowPay isShowSupplier:(BOOL)isShowSupplier;

- (id)init DEPRECATED_ATTRIBUTE;
@end
