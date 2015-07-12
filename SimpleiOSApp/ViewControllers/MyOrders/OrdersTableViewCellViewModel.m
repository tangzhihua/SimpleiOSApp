
#import "OrdersTableViewCellViewModel.h"

@implementation OrdersTableViewCellViewModel
- (instancetype)initWithOrderInfoModel:(OrderInfo *)orderInfoModel {
  if ((self = [super init])) {
    _orderInfoModel = orderInfoModel;
    
    _orderTitle = orderInfoModel.lastminute_title;// 订单标题
    _orderNumber = orderInfoModel.orderId;// 订单号
    switch (orderInfoModel.products_type) {// 付款类型
      case ProductTypeTagEnum_All:
        _paymentType = @"全款";
        break;
      case ProductTypeTagEnum_Header:
        _paymentType = @"预付款";
        break;
      case ProductTypeTagEnum_Footer:
        _paymentType = @"余款";
        break;
    }

    _productType = orderInfoModel.products_title;// 产品类型
    _departureDate = orderInfoModel.products_departure_date;// 出发日期
    _price = orderInfoModel.unit_price;// 单价
    _productNumber = orderInfoModel.num;// 预定数量
    _singleRoomDifference = orderInfoModel.room_price_total;// 单房差
    _paymentTotal = orderInfoModel.price;// 支付总额
    
    // 订单状态
    _orderState = orderInfoModel.payment;
  }
  
  return self;
}
@end
