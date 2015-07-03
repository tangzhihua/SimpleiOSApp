//
//  CETweetTableViewCell.m
//  CETableViewBinding
//
//  Created by Colin Eberhardt on 28/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "FavoritTableViewCell.h"
#import "FavoritTableViewCellViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface FavoritTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;


@end

@implementation FavoritTableViewCell

- (void)bindViewModel:(FavoritTableViewCellViewModel *)viewModel {
  self.titleLabel.text = viewModel.title;
  self.priceLabel.text = viewModel.price;
  self.endDateLabel.text = viewModel.endDate;
}

@end
