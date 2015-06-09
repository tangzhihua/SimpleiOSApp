
#import "AppInit.h"

#import "MKNetworkEngineSingletonForImageDownload.h"
#import "UIImageView+MKNetworkKitAdditions.h"
#import "SimpleNetworkEngineSingleton.h"
#import "GlobalDataCacheForMemorySingleton.h"
#import "LocalCacheDataPathConstant.h"

@implementation AppInit



+ (void)initApp {
 
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{
    
    // 打印当前设备的信息
    [AppInit printDeviceInfo];
    
 
    // 初始化 图片加载模块 ---- 目前使用MK自带的
    [MKNetworkEngineSingletonForImageDownload sharedInstance];
    [UIImageView setDefaultEngine:[MKNetworkEngineSingletonForImageDownload sharedInstance]];
    
    // 初始化一些单例类
    //
    [SimpleNetworkEngineSingleton sharedInstance];
    //
    [GlobalDataCacheForMemorySingleton sharedInstance];
    
    
    // 创建本地缓存目录
    [LocalCacheDataPathConstant createLocalCacheDirectories];
    
  });
  return;
}

+ (void) printDeviceInfo {
  UIDevice *device =[UIDevice currentDevice];
  NSLog(@"    ");
  NSLog(@"-----------------------------");
  NSLog(@"    ");
  NSLog(@"设备信息:");
  NSLog(@"    ");
  NSLog(@"当前app所在路径        = %@", NSHomeDirectory());
  NSLog(@"device.name          = %@", device.name);// e.g. "My iPhone"
  NSLog(@"device.model         = %@", device.model);// e.g. @"iPhone", @"iPod touch"
  NSLog(@"device.localizedModel= %@", device.localizedModel);// localized version of model
  NSLog(@"device.systemName    = %@", device.systemName);// e.g. @"iOS"
  NSLog(@"device.systemVersion = %@", device.systemVersion);// e.g. @"4.0"
  
  
  NSLog(@"    ");
  NSLog(@"    ");
  NSLog(@"App信息:");
  NSLog(@"    ");
  NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
  NSLog(@"infoDictionary.CFBundleIdentifier            = %@", [infoDic objectForKey:@"CFBundleIdentifier"]);
  NSLog(@"infoDictionary.CFBundleInfoDictionaryVersion = %@", [infoDic objectForKey:@"CFBundleInfoDictionaryVersion"]);
  NSLog(@"infoDictionary.CFBundleName                  = %@", [infoDic objectForKey:@"CFBundleName"]);
  NSLog(@"infoDictionary.CFBundleShortVersionString    = %@", [infoDic objectForKey:@"CFBundleShortVersionString"]);
  NSLog(@"infoDictionary.CFBundleVersion               = %@", [infoDic objectForKey:@"CFBundleVersion"]);
  NSLog(@"    ");
  NSLog(@"-----------------------------");
  NSLog(@"    ");
}
@end
