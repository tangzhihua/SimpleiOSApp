//
//  DreamBook
//
//  Created by 唐志华 on 13-9-18.
//
//

#import "LocalCacheDataPathConstant.h"
#import "SimpleFolderTools.h"

@implementation LocalCacheDataPathConstant

// 静态初始化方法
+ (void) initialize {
  // 这是为了子类化当前类后, 父类的initialize方法会被调用2次
  if (self == [LocalCacheDataPathConstant class]) {
    
  }
}

+ (NSString *)rootDirectoryPath {
  static NSString *path = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    path = paths[0];
  });
  return path;
}

// 项目中图片缓存目录 (可以被清除)
+ (NSString *)thumbnailCachePath {
  static NSString *path = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{
    path = [[self rootDirectoryPath] stringByAppendingPathComponent:@"ThumbnailCachePath"];
  });
  return path;
}

// 那些需要始终被保存, 不能由用户进行清除的文件
+ (NSString *)importantDataCachePath {
  static NSString *path = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{
    path = [[self rootDirectoryPath] stringByAppendingPathComponent:@"ImportantDataCache"];
  });
  return path;
}

// 业务Bean缓存目录(可以被删除)
+ (NSString *)domainbeanCachePath {
  static NSString *path = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{
    path = [[self rootDirectoryPath] stringByAppendingPathComponent:@"DomainBeanCache"];
  });
  return path;
}


// 能否被用户清空的目录数组(可以从这里获取用户可以直接清空的文件夹路径数组)
+ (NSArray *)directoriesCanBeClearByTheUser {
  NSArray *directories = [NSArray arrayWithObjects:[self thumbnailCachePath], [self domainbeanCachePath], nil];
  return directories;
}

// 创建本地数据缓存目录(一次性全部创建, 不会重复创建)
+ (void)createLocalCacheDirectories {
  // 创建本地数据缓存目录(一次性全部创建, 不会重复创建)
  NSArray *directories = [NSArray arrayWithObjects:[self thumbnailCachePath], [self importantDataCachePath], [self domainbeanCachePath], nil];
  
  NSFileManager *fileManager = [NSFileManager defaultManager];
  for (NSString *path in directories) {
    if (![fileManager fileExistsAtPath:path]) {
      [fileManager createDirectoryAtPath:path
             withIntermediateDirectories:YES
                              attributes:nil
                                   error:nil];
    }
    
    PRPLog(@"\n\n本地缓存目录:\n%@\n\n", path);
  }
  
}

// 本地缓存的数据的大小(字节)
+ (long long)localCacheDataSize {
  long long size = 0;
  NSArray *directories = [LocalCacheDataPathConstant directoriesCanBeClearByTheUser];
  for(NSString *directory in directories) {
    size += [SimpleFolderTools folderSizeAtPath3:directory];
  }
  
  return size;
}
@end
