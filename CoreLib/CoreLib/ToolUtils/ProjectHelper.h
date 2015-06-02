 
#import <Foundation/Foundation.h>


@interface ProjectHelper : NSObject

/**
 * 获取Qyer登录加密串
 *
 * @param username
 * @param password
 * @return
 */
+ (NSString *)AccountSWithUsername:(NSString *)username andPassword:(NSString *)password;
@end
