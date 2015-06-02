

#import "SpliceFullUrlByDomainBeanSpecialPath.h"

@implementation SpliceFullUrlByDomainBeanSpecialPath
- (NSString *)fullUrlByDomainBeanSpecialPath:(NSString *)specialPath {
  return [NSString stringWithFormat:@"%@/%@", LastMinute_UrlConstant_MainUrl, specialPath];
}
@end
