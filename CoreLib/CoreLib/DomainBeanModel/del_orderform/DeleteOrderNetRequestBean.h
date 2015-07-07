
#import <Foundation/Foundation.h>

@interface DeleteOrderNetRequestBean : NSObject
// ID
@property (nonatomic, copy, readonly) NSNumber *ID;

#pragma mark -
#pragma mark - 构造方法
- (id)initWithID:(NSNumber *)ID;

- (id)init DEPRECATED_ATTRIBUTE;
@end
