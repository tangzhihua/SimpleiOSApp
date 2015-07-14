
#import <Foundation/Foundation.h>

@interface DeleteSubscribeNetRequestBean : NSObject
//
@property (nonatomic, copy, readonly) NSString *subscribeId;

#pragma mark -
#pragma mark - 构造方法
- (id)initWithSubscribeId:(NSString *)subscribeId;

- (id)init DEPRECATED_ATTRIBUTE;
@end
