

#import <Foundation/Foundation.h>

@interface MySimpleToast : NSObject

/**
 *  显示一个toast
 *
 *  @param text     toast 中的文字信息
 *  @param duration 持续的时间
 */
+ (void)showWithText:(NSString *)text duration:(int)duration;
@end
