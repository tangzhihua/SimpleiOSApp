

#import "SimpleToast.h"
#import "MBProgressHUD.h"

@implementation SimpleToast
+ (void)showWithText:(NSString *)text duration:(int)duration {
  UIWindow *window = [UIApplication sharedApplication].windows[0];
  
  MBProgressHUD *toast = [MBProgressHUD showHUDAddedTo:window animated:YES];
  
  // Configure for text only and offset down
  toast.mode = MBProgressHUDModeText;
  // 支持折行
  toast.detailsLabelText = text;
  toast.margin = 10.f;
  toast.removeFromSuperViewOnHide = YES;
  
  [toast hide:YES afterDelay:duration];
}
@end
