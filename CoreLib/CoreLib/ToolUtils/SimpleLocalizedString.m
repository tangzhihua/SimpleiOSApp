//
//  SimpleLocalizedString.m
//  MyPlatformSDK
//
//  Created by 包治百病的板蓝根/隐身犬 on 15/5/7.
//  Copyright (c) 2015年 Eagamebox. All rights reserved.
//

#import "SimpleLocalizedString.h"
NSString *EagameboxLocalizedString(NSString *key, NSString *comment) {
  NSString *myBundlePath = [[NSBundle mainBundle] pathForResource:@"Eagameboxs" ofType:@"bundle"];
  NSBundle *myBundle = [NSBundle bundleWithPath:myBundlePath];
  return NSLocalizedStringFromTableInBundle(key, @"Eagameboxs", myBundle, comment);
}
