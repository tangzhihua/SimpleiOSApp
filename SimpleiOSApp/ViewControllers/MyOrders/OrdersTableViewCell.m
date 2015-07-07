//
//  CETweetTableViewCell.m
//  CETableViewBinding
//
//  Created by Colin Eberhardt on 28/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

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
