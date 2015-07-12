
#import "OrdersTableViewCell.h"
#import "OrdersTableViewCellViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "OrderInfo.h"

@interface OrdersTableViewCell()
// 订单标题, 点击之后跳转订单详情
@property (weak, nonatomic) IBOutlet UIButton *orderTitleButton;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;

// 订单状态 - 支付超时
@property (weak, nonatomic) IBOutlet UIView *orderStateForTimeout;
// 订单状态 - 未支付
@property (weak, nonatomic) IBOutlet UIView *orderStateForUnpaid;
// 支付时间倒计时标签
@property (weak, nonatomic) IBOutlet UILabel *payTimeCountdownLabel;
// 订单状态 - 已支付
@property (weak, nonatomic) IBOutlet UIView *orderStateForPaid;
// 支付按钮
@property (weak, nonatomic) IBOutlet UIButton *payButton;


@end

@implementation OrdersTableViewCell

- (void)bindViewModel:(OrdersTableViewCellViewModel *)viewModel {
 
  [_orderTitleButton setTitle:viewModel.orderTitle forState:UIControlStateNormal];
  
  _orderStateForTimeout.hidden = YES;
  _orderStateForUnpaid.hidden = YES;
  _orderStateForPaid.hidden = YES;
  switch (viewModel.orderState) {
    case OrderPaymemtTagEnum_Timeout:
      _orderStateForTimeout.hidden = NO;
      break;
    case OrderPaymemtTagEnum_Unpaid:
      _orderStateForUnpaid.hidden = NO;
      break;
    case OrderPaymemtTagEnum_Paid:
      _orderStateForPaid.hidden = NO;
      break;
  }
  
  _label1.text = [NSString stringWithFormat:@"订 单  号 : %@", viewModel.orderNumber];
  _label2.text = [NSString stringWithFormat:@"付款类型 : %@", viewModel.paymentType];
  _label3.text = [NSString stringWithFormat:@"产品类型 : %@", viewModel.productType];
  _label4.text = [NSString stringWithFormat:@"出发日期 : %@", viewModel.departureDate];
  _label5.text = [NSString stringWithFormat:@"单       价 : %@ 元", viewModel.price];
  _label6.text = [NSString stringWithFormat:@"预定数量 : %@", viewModel.productNumber];
  
  _label7.hidden = YES;
  _label8.hidden = YES;
  if (viewModel.singleRoomDifference.integerValue > 0) {
    _label7.hidden = NO;
    _label8.hidden = NO;
    
    _label7.text = [NSString stringWithFormat:@"单 房  差 : %@ 元", viewModel.singleRoomDifference];
    _label8.text = [NSString stringWithFormat:@"支付总额 : %@ 元", viewModel.paymentTotal];
  } else {
    _label7.hidden = NO;
    
    _label7.text = [NSString stringWithFormat:@"支付总额 : %@ 元", viewModel.paymentTotal];
  }

  @weakify(self);
  [[self.orderTitleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    @strongify(self);

    if (!self.isEditing) {
      [self.selectionArray[0] execute:viewModel];
    }
    
  }];
 
  [[self.payButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    @strongify(self);

    if (!self.isEditing) {
      [self.selectionArray[1] execute:viewModel];
    }
    
  }];
}

@end
