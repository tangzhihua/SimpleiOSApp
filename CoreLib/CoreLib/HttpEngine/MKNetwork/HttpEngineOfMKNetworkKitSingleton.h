//
//  HttpEngineOfMKNetworkKitSingleton.h
//  KalendsPlatformSDK
//
//  Created by skyduck on 14-10-6.
//  Copyright (c) 2014年 Kalends. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INetLayerInterface.h"

@interface HttpEngineOfMKNetworkKitSingleton : NSObject <INetLayerInterface>
+ (id<INetLayerInterface>) sharedInstance;
@end
