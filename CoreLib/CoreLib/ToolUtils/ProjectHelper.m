
#import "ProjectHelper.h"
#import "NSString+Helper.h"
//
#import "NSString+MKNetworkKitAdditions.h"

@implementation ProjectHelper

#pragma mark
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id) init {
  RNAssert(NO, @"Can not use the default init method!");
  
  return nil;
}

#pragma mark
#pragma mark 对外的公开的工具类
/**
 * 获取Qyer登录加密串
 *
 * @param username
 * @param password
 * @return
 */
+ (NSString *)AccountSWithUsername:(NSString *)username andPassword:(NSString *)password {
  NSMutableString *temp = [NSMutableString string];
  //
  [temp appendString:[username substringFrom:0 to:2]];
  //
  [temp appendString:[password substringFrom:0 to:2]];
  //
  [temp appendString:[username substringFrom:username.length - 2 to:username.length]];
  //
  [temp appendString:[password substringFrom:password.length - 2 to:password.length]];
  
  return [[[[temp md5] lowercaseString] md5] lowercaseString];
}
@end
