

#ifndef LastMinute_LoginDatabaseFieldsConstant_h
#define LastMinute_LoginDatabaseFieldsConstant_h

/************      RequestBean       *************/



// 登录名
#define LastMinute_Login_RequestKey_username        @"username"
// 密码
#define LastMinute_Login_RequestKey_password         @"password"
//
#define LastMinute_Login_RequestKey_account_s    @"account_s"
//
#define LastMinute_Login_RequestKey_grant_type    @"grant_type"

/************      RespondBean       *************/


// 访问令牌
#define LastMinute_Login_RespondKey_access_token          @"access_token"
// 过期时间
#define LastMinute_Login_RespondKey_expires_in           @"expires_in"
// 授权范围
#define LastMinute_Login_RespondKey_scope         @"scope"

// 用户信息
#define LastMinute_Login_RespondKey_user_info      @"user_info"

// 用户ID
#define LastMinute_Login_RespondKey_uid       @"uid"
// 用户名称
#define LastMinute_Login_RespondKey_userName       @"userName"
// 邮箱
#define LastMinute_Login_RespondKey_email       @"email"
// 性别 0 保密 1 男 2 女
#define LastMinute_Login_RespondKey_gender       @"gender"
// 自我介绍
#define LastMinute_Login_RespondKey_bio       @"bio"
// 最后访问时间
#define LastMinute_Login_RespondKey_lastVisit       @"lastVisit"
// 个人头像图片url地址
#define LastMinute_Login_RespondKey_avatar       @"avatar"
// 用户手机号码
#define LastMinute_Login_RespondKey_phone       @"phone"
 


#endif
