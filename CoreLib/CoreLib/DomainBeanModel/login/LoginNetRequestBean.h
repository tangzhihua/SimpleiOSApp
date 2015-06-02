
#import <Foundation/Foundation.h>

@interface LoginNetRequestBean : NSObject 
// 用户名
@property (nonatomic, copy, readonly) NSString *username;
// 密码
@property (nonatomic, copy, readonly) NSString *password;

#pragma mark -
#pragma mark - 构造方法
- (id)initWithUsername:(NSString *)username password:(NSString *)password;

- (id)init DEPRECATED_ATTRIBUTE;
@end
