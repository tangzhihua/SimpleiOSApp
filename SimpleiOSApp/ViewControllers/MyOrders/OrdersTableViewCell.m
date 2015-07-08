
#import "OrdersTableViewCell.h"
#import "OrdersTableViewCellViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface OrdersTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;


@end

@implementation OrdersTableViewCell

- (void)bindViewModel:(OrdersTableViewCellViewModel *)viewModel {
 
}

@end
