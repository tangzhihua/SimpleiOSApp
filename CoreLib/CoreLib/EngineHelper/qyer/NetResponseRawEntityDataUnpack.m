

#import "NetResponseRawEntityDataUnpack.h"



@implementation NetResponseRawEntityDataUnpack
- (id) init {
	
	if ((self = [super init])) {

	}
	
	return self;
}

#pragma mark -
#pragma mark - 实现 INetResponseRawEntityDataUnpack 接口
- (NSString *) unpackNetResponseRawEntityDataToUTF8String:(in NSData *) rawData {
  do {
    if (![rawData isKindOfClass:[NSData class]] || rawData.length <= 0) {
      // 入参异常
      break;
    }
    
    // 将 "原生数据" 转成 "UTF-8字符串"
    NSString *stringOfUTF8 = [[NSString alloc] initWithData:rawData encoding:NSUTF8StringEncoding];
    if (![stringOfUTF8 isKindOfClass:[NSString class]] || stringOfUTF8.length <= 0) {
      //
      break;
    }
    return stringOfUTF8;
  } while (NO);
  
  
  // 出现错误
  return @"";
}
@end