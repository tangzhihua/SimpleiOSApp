//
//  CETableViewCell.h
//  Pods
//
//  Created by skyduck on 15/7/8.
//
//

#import <UIKit/UIKit.h>
#import "CEReactiveView.h"

@interface CETableViewCell : UITableViewCell <CEReactiveView>

// 外部传入的点击事件响应群
@property (nonatomic, strong) NSArray *selectionArray;

// 是否自己处理 "点击事件"
// 注 : 子类可以决定是否覆写这个方法, 如果子类要自己处理 "点击事件", 那么就不会响应
// tableView:didSelectRowAtIndexPath: 代理了
// 父类默认返回 NO.
- (BOOL)isOneselfHandleSelectionCommand;

@end
