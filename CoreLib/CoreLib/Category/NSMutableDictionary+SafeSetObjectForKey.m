

#import "NSMutableDictionary+SafeSetObjectForKey.h"

@implementation NSMutableDictionary (SafeSetObjectForKey)
- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey {
  
  if (anObject == nil || aKey == nil) {
    return;
  }
  
  [self setObject:anObject forKey:aKey];
}

- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey defaultValue:(id)defaultValue {
  if (aKey == nil) {
    return;
  }
  
  if (anObject == nil) {
    anObject = defaultValue;
  }
  
  @try{
    [self setObject:anObject forKey:aKey];
  } @catch(NSException* e) {

  }
}
@end
