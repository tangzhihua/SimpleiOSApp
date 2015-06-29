//
//  ViewController.m
//  SimpleiOSApp
//
//  Created by skyduck on 15/5/31.
//  Copyright (c) 2015年 Skyduck. All rights reserved.
//

#import "ViewController.h"

// ReactiveCocoa
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation ViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
 
  RAC(self.outputLabel, text, @"收到nil时就显示我") = self.inputTextField.rac_textSignal;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
