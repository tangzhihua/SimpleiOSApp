//
//  ModelBase.h
//  Steinlogic
//
//  Created by Mugunth Kumar on 26-Jul-10.
//  Copyright 2011 Steinlogic All rights reserved.
//
//  所有Model的父类, 主要是封装了KVC, 通过入参 : 数据字典 来直接反射成业务Bean
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject <NSCoding, NSCopying, NSMutableCopying>

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryObject;

@end

/* --------------> 下面说明了为什么使用 instancetype 作为init方法的返回值类型
 
// 作为返回值 instancetype 表示 "当前类"
// 如果这里使用 Foo * 或者 id 类型替换 instancetype的话,
// 都会在有子类继承Foo时,使用父类的方便构造创建对象时, 会报类型转换的警告
// 所以, 为保持一致性, init方法和方便构造方法的返回类型最好都用 instancetype
@interface Foo : NSObject
+ (instancetype)fooWithInt:(int)x;
@end

@interface SpecialFoo : Foo
@end

...

SpecialFoo *sf = [SpecialFoo fooWithInt:1];
----------------------------------------------------------------------*/