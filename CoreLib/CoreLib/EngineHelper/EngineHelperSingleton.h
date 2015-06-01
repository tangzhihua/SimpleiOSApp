//
//  EngineHelperSingleton.h
//  CoreLib
//
//  Created by skyduck on 14-10-6.
//  Copyright (c) 2014年 Skyduck. All rights reserved.
//

#import "IEngineHelper.h"

@interface EngineHelperSingleton : NSObject <IEngineHelper>
 
+ (id<IEngineHelper>)sharedInstance;
@end
