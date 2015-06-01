

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SafeSetObjectForKey)

/**
 *  安全的调用 NSMutableDictionary 的 - (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey 方法
 *  内部会判断 value 和 key 的有效性, 为nil时, 直接return.
 *
 *  @param anObject 值
 *  @param aKey     键
 */
- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey;

/**
 *  可以设置默认值的安全设置对象
 *
 *  @param anObject
 *  @param aKey
 *  @param defaultValue 默认值
 */
- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey defaultValue:(id)defaultValue;
@end
