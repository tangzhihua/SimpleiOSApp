

#import "SimpleProgressBar.h"
#import "MBProgressHUD.h"


static MBProgressHUD *_loadingHUD = nil;
static NSInteger _hudReferenceCounter = 0;

@implementation SimpleProgressBar

+ (void) show {
  _hudReferenceCounter++;
  if (_loadingHUD == nil) {
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    _loadingHUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
  }
}
+ (void) dismiss {
  _hudReferenceCounter--;
  if (_hudReferenceCounter <= 0) {
    [_loadingHUD hide:YES];
    _loadingHUD = nil;
  }
}

@end
