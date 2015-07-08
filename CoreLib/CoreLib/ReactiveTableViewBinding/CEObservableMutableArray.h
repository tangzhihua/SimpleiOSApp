//
//  CEObservableMutableArray.h
//  CETableViewBinding
//
//  Created by Colin Eberhardt on 29/10/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CEObservableMutableArray;

/// a protocol that is used by observers of the CEObservableMutableArray to determine
/// when the array is mutated
@protocol CEObservableMutableArrayDelegate <NSObject>

@optional

/// invoked when an item is added to the array
- (void)array:(CEObservableMutableArray *)array didAddItemAtIndex:(NSUInteger) index;

/// invoked when an item is removed from the aray
- (void)array:(CEObservableMutableArray *)array didRemoveItemAtIndex:(NSUInteger) index;

/// invoked when an item is replaced
- (void)array:(CEObservableMutableArray *)array didReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end

// 20150704 skyduck CEObservableMutableArray 删除数据时调用的回调
@protocol SkyduckCEObservableMutableArrayRemoveDelegate <NSObject>

@optional

/// 当删除CEObservableMutableArray数据时, 就会调用这个delegate
- (void)removedObject:(id)obj;
@end

/// a mutable array that informs the delegate of mutations
@interface CEObservableMutableArray : NSMutableArray

- (instancetype) initWithArray:(NSArray *)array;
// 20150704 : skyduck 这个delegate是为CETableViewBindingHelper准备的,
//            我目前还没发现如何在外部监控数据源的变化, 所以我在这里多增加一个 delegate 为我所用
@property (nonatomic, weak) id<CEObservableMutableArrayDelegate> delegate;

@property (nonatomic, weak) id<SkyduckCEObservableMutableArrayRemoveDelegate> delegateForRemoved;
@end


