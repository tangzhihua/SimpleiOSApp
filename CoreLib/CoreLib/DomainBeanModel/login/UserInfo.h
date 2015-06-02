
#import "BaseModel.h"

typedef NS_ENUM(NSInteger, SexEnum) {
  // 保密
  SexEnum_Secrecy = 0,
  // 男
  SexEnum_Male = 1,
  // 女
  SexEnum_Female = 2,
};

//  
@interface UserInfo : BaseModel

//
@property (nonatomic, copy) NSString *uid;
//
@property (nonatomic, copy) NSString *username;
//
@property (nonatomic, copy) NSString *email;
//
@property (nonatomic, assign) SexEnum gender;
//
@property (nonatomic, copy) NSString *bio;
//
@property (nonatomic, assign) NSInteger lastVisit;
//
@property (nonatomic, copy) NSString *avatar;
//
@property (nonatomic, copy) NSString *phone;
@end
