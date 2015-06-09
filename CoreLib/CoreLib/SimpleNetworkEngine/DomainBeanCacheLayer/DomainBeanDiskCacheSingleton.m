//
//  DomainBeanDiskStorageSingleton.m
//  CoreLib
//
//  Created by skyduck on 15/6/5.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import "DomainBeanDiskCacheSingleton.h"

#import <sqlite3.h>

#import "LocalCacheDataPathConstant.h"

@implementation DomainBeanDiskCacheSingleton {
  sqlite3 *_database;
}
#pragma mark -
#pragma mark Singleton Implementation

// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
- (id)init {
  // 禁止调用 -init 或 +new
  RNAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

// 真正的(私有)init方法
- (id)initSingleton {
  
  if ((self = [super init])) {
    // 初始化代码
    
    
    NSString *dbFilePath = [[LocalCacheDataPathConstant domainbeanCachePath] stringByAppendingPathComponent:@"domainbean_cache.db"];
    if (sqlite3_open([dbFilePath UTF8String], &_database) == SQLITE_OK) {
      int result = 0;
      char *errorMessageOUT = NULL;
      // 创建 table
      
      NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'DomainBeanCache' (id TEXT PRIMARY KEY, 'RespondData' TEXT, 'LastDate' TEXT)"];
      if (sqlite3_exec(_database, [sql UTF8String], nil, nil, &errorMessageOUT) == SQLITE_OK) {
        // 创建表成功
      }
      result = sqlite3_exec(_database, [sql UTF8String], nil, nil, &errorMessageOUT);
      
      //
      sql = [NSString stringWithFormat:@"INSERT INTO 'DomainBeanCache' VALUES('1234567','{000}','100000')"];
      result = sqlite3_exec(_database, [sql UTF8String], nil, nil, &errorMessageOUT);
      //
      sql = [NSString stringWithFormat:@"INSERT INTO 'DomainBeanCache' VALUES('1234567','{000}','100000')"];
      result = sqlite3_exec(_database, [sql UTF8String], nil, nil, &errorMessageOUT);
      
      NSLog(@"");
    } else {
      sqlite3_close(_database);
    }
    
  }
  
  return self;
}

+ (id<IDomainBeanCacheControl>) sharedInstance {
  static id<IDomainBeanCacheControl> singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}
@end
