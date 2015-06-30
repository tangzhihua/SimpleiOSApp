
#import <Foundation/Foundation.h>

@interface RegistNetRequestBean : NSObject
// 邮箱
@property (nonatomic, copy, readonly) NSString *email;
// 用户名
@property (nonatomic, copy, readonly) NSString *username;
// 密码
@property (nonatomic, copy, readonly) NSString *password;

#pragma mark -
#pragma mark - 构造方法
- (id)initWithEmail:(NSString *)email username:(NSString *)username password:(NSString *)password;

- (id)init DEPRECATED_ATTRIBUTE;
@end
