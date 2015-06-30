//
//  RegisterViewController.m
//  SimpleiOSApp
//
//  Created by skyduck on 15/6/29.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import "RegisterViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RegistNetRequestBean.h"
#import "RegistNetRespondBean.h"
#import "SimpleNetworkEngineSingleton.h"
#import "NetRequestHandleNilObject.h"
#import "SimpleProgressBar.h"
#import "SimpleToast.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmCheckBox;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (nonatomic, strong) id<INetRequestHandle> netRequestHandleForRegister;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  @weakify(self);
  
  // 用户隐私条款的确认按钮(CheckBox)
  RAC(self.confirmCheckBox, selected) =
  [[self.confirmCheckBox rac_signalForControlEvents:UIControlEventTouchUpInside]
   map:^id(UIButton *button) {
     return @(!button.selected);
   }];
  
  // 判断用户输入的 "邮箱" 和 "用户名" 和 "密码" 是否有效的信号
  RACSignal *validEmailSignal = [self.emailTextField.rac_textSignal map:^id(NSString *text) {
    @strongify(self);
    return @([self isValidEmail:text]);
  }];
  
  RACSignal *validUsernameSignal = [self.usernameTextField.rac_textSignal map:^id(NSString *text) {
    @strongify(self);
    return @([self isValidUsername:text]);
  }];
  
  // 用户输入的原始密码是否有效
  RACSignal *validPasswordSignal = [self.passwordTextField.rac_textSignal map:^id(NSString *text) {
    @strongify(self);
    return @([self isValidPassword:text]);
  }];
  // 用户输入的确认密码是否有效, 确认密码有效意味着密码输入有效
  RACSignal *validRepeatPasswordSignal
  = [RACSignal
     combineLatest:@[self.passwordTextField.rac_textSignal, self.repeatPasswordTextField.rac_textSignal]
     reduce:^id(NSString *password, NSString *repeatPassword){
       @strongify(self);
       return @([self isValidPassword:password] && [password isEqualToString:repeatPassword]);
     }];
  
  RACSignal *validConfirmCheckBox = RACObserve(self.confirmCheckBox, selected);
  
  // 控制输入框的背景颜色(输入数据有效和无效时的背景颜色不同)
  RAC(self.emailTextField, backgroundColor)
  = [validEmailSignal map:^id(NSNumber *isEmailValid) {
    return isEmailValid.boolValue ? [UIColor clearColor] : [UIColor yellowColor];
  }];
  
  RAC(self.usernameTextField, backgroundColor)
  = [validUsernameSignal map:^id(NSNumber *isUsernameValid) {
    return isUsernameValid.boolValue ? [UIColor clearColor] : [UIColor yellowColor];
  }];
  
  RAC(self.passwordTextField, backgroundColor)
  = [validPasswordSignal map:^id(NSNumber *isPasswordValid) {
    return isPasswordValid.boolValue ? [UIColor clearColor] : [UIColor yellowColor];
  }];
  
  RAC(self.repeatPasswordTextField, backgroundColor)
  = [validRepeatPasswordSignal map:^id(NSNumber *isPasswordValid) {
    return isPasswordValid.boolValue ? [UIColor clearColor] : [UIColor yellowColor];
  }];
  
  // 控制 "注册按钮" 的 enabled 状态的信号
  RACSignal *registerButtonEnabledSignal
  = [RACSignal combineLatest:@[validEmailSignal, validUsernameSignal, validRepeatPasswordSignal, validConfirmCheckBox]
                      reduce:^id(NSNumber *isEmailValid, NSNumber *isUsernameValid, NSNumber *isPasswordValid, NSNumber *isConfirmValid){
                        return @(isEmailValid.boolValue && isUsernameValid.boolValue && isPasswordValid.boolValue && isConfirmValid.boolValue);
                      }];
  
  // 点击 "注册按钮" 之后的事件流
  RACCommand *registerCommand
  = [[RACCommand alloc] initWithEnabled:registerButtonEnabledSignal signalBlock:^RACSignal *(id input) {
    RegistNetRequestBean *registNetRequestBean = [[RegistNetRequestBean alloc] initWithEmail:self.emailTextField.text username:self.usernameTextField.text password:self.passwordTextField.text];
    return [[self signalForRegisterWithRegistNetRequestBean:registNetRequestBean] materialize];
  }];
  
  // 监控command是否正在执行中
  [registerCommand.executing subscribeNext:^(NSNumber *isExecuting) {
    if (isExecuting.boolValue) {
      [SimpleProgressBar show];
    } else {
      [SimpleProgressBar dismiss];
    }
  }];
  
  // 从command订阅执行结果
  [registerCommand.executionSignals subscribeNext:^(RACSignal *subscribeSignal) {
    [[[subscribeSignal dematerialize] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RegistNetRespondBean *registNetRespondBean) {
      // 注册成功
    } error:^(NSError *error) {
      // 注册失败
      NSLog(@"");
    }];
  }];
  
  
  self.registerButton.rac_command = registerCommand;
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (BOOL)isValidEmail:(NSString *)email {
  return email.length > 6;
}

- (BOOL)isValidUsername:(NSString *)username {
  return username.length > 6;
}

- (BOOL)isValidPassword:(NSString *)password {
  return password.length >= 6;
}

- (RACSignal *)signalForRegisterWithRegistNetRequestBean:(RegistNetRequestBean *)registNetRequestBean {
  
  @weakify(self)
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    @strongify(self);
    
    //
    self.netRequestHandleForRegister
    = [[SimpleNetworkEngineSingleton sharedInstance] requestDomainBeanWithRequestDomainBean:registNetRequestBean isUseCache:NO successedBlock:^(id respondDomainBean) {
      [subscriber sendNext:respondDomainBean];
      [subscriber sendCompleted];
    } failedBlock:^(ErrorBean *error) {
      [subscriber sendError:error];
    }];
    
    //
    return [RACDisposable disposableWithBlock:^{
      @strongify(self);
      [self.netRequestHandleForRegister cancel];
    }];
  }];
}

@end
