
#import "UIPopoverController+Tag.h"
#import <objc/runtime.h>

// 关联引用有两点需要知道:
// 1.虽然不能在分类中创建实例变量, 但是可以创建关联引用. 通过关联引用,
//   你可以想任何对象中添加键-值(key-value)数据.(可以给任意一个对象添加键值数据)
// 2.关联引用(或是其他一些通过分类添加数据的方法)有个限制, 即无法使用 encodeWithCoder:方法,
//   所以通过分类进行序列化是非常困难的.

@implementation UIPopoverController (Tag)
@dynamic tag;

// 可以看出, 关联引用是基于键(key)的内存地址的, 而不是键的值. 在 tagKey 中存储的内容并不重要, 但是它需要一个唯一地址,
// 所以通常使用一个未赋值的 static char 作为键.
static char kTagKey;

- (NSInteger)tag {
  NSNumber *tagNumber = objc_getAssociatedObject(self, &kTagKey);
  return tagNumber.integerValue;
}

- (void)setTag:(NSInteger)tag {
  NSNumber *tagNumber = [NSNumber numberWithInteger:tag];
  // 关联引用有良好的内存管理, 能根据传递给 objc_setAssociatedObject 的参数正确处理 copy/assign/retain等语义.
  objc_setAssociatedObject(self, &kTagKey, tagNumber, OBJC_ASSOCIATION_ASSIGN);
}
@end


// 当相关对象被销毁时, 关联引用会被释放.这个事实意味着可以用关联引用来追踪另一个对象何时被销毁.
// 这种技术对于调试很有用, 不过也可以用作非调试的目的, 比如执行清理工作.
/*
const char kWatcherKey;
@interface Watcher : NSObject
@end

@implementation Watcher

- (void) dealloc {
  NSLog(@"the thing I was watching is going away.");
}

@end

...

NSObject *something = [NSObject new];
objc_setAssociatedObject(something, &kWatcherKey, [Watcher new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
*/