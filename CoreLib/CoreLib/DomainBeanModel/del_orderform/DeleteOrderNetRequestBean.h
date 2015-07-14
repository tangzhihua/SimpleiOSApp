
#import <Foundation/Foundation.h>

@interface DeleteOrderNetRequestBean : NSObject
//
@property (nonatomic, copy, readonly) NSString *orderId;

#pragma mark -
#pragma mark - 构造方法
- (id)initWithOrderId:(NSString *)orderId;

- (id)init DEPRECATED_ATTRIBUTE;
@end
