

#import "NetResponseDataToNSDictionary.h"

@implementation NetResponseDataToNSDictionary
- (NSDictionary *)netResponseDataToNSDictionary:(in NSString *)serverResponseDataOfUTF8String {
  NSString *errorMessage = nil;
  do {
    if ([NSString isEmpty:serverResponseDataOfUTF8String]) {
      errorMessage = @"入参 serverResponseDataOfUTF8String 为空 !";
      break;
    }
    
    NSError *error = nil;
    NSData *data = [serverResponseDataOfUTF8String dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonRootNSDictionary =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error != nil) {
      errorMessage = [error localizedDescription];
      break;
    }
    if (![jsonRootNSDictionary isKindOfClass:[NSDictionary class]]) {
      errorMessage = [NSString stringWithFormat:@"json 解析失败!-->serverResponseDataOfUTF8String = %@ ", serverResponseDataOfUTF8String];
      break;
    }
    
		return jsonRootNSDictionary;
	} while (NO);
  
  // 转化 ResponseData 成 NSDictionary 失败
  return nil;
}
@end
