//
//  LoginManager.h
//
//
//  Created by 唐志华 on 20150628.
//
//  用户登录模块(操作用户登录, 保存登录之后的用户信息)
//
//
//
//

#import <Foundation/Foundation.h>


@class LoginNetRequestBean;
@class LoginNetRespondBean;

@interface LoginManager : NSObject

// 用户登录成功后, 服务器返回的 "用户信息", 可以通过判断这个属性是否为空来判断当前是否有用户处于登录状态
@property (nonatomic, readonly, strong) LoginNetRespondBean *latestLoginNetRespondBean;


/// 通过下面两个方法来设置上面的只读属性
- (RACSignal *)signalForLoginWithLoginNetRequestBean:(LoginNetRequestBean *)loginNetRequestBean;

- (void)logout;

#pragma mark -
#pragma mark - 单例
+ (instancetype) sharedInstance;
@end
