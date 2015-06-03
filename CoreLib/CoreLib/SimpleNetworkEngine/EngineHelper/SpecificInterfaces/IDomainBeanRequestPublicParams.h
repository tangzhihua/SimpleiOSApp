//
//  IDomainBeanRequestPublicParams.h
//
//  CoreLib
//
//  Created by skyduck on 2015-6-1.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ErrorBean;
@protocol IDomainBeanRequestPublicParams <NSObject>
- (NSDictionary *)publicParamsWithErrorOUT:(ErrorBean **)errorOUT;
@end
