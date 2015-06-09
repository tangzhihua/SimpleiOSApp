//
//  DomainBeanDiskStorage.h
//  CoreLib
//
//  Created by skyduck on 15/6/5.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDomainBeanCacheControl.h"

@interface DomainBeanMemoryCacheSingleton : NSObject <IDomainBeanCacheControl>
+ (id<IDomainBeanCacheControl>) sharedInstance;
@end
