
#import "NetRequestParamsPackage.h"



static const NSString *const TAG = @"<NetRequestParamsPackageForKunlun>";

@implementation NetRequestParamsPackage
- (id) init {
	
	if ((self = [super init])) {
		
	}
	
	return self;
}

#pragma mark 实现 INetRequestParamsPackage 接口方法
/**
 *  将业务数据字典, 打包成POST方式传递的数据
 *
 *  @param domainDD 业务数据字典
 *
 *  @return 打包之后的POST数据
 */
- (NSData *)packageNetRequestParamsWithDomainDataDictionary:(in NSDictionary *)domainDD {
  
  return nil;
}
@end
