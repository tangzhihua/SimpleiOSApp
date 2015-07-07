
#import "OrdersViewController.h"
#import "OrdersViewModel.h"
#import "SimpleProgressBar.h"
#import "SimpleToast.h"
#import "CETableViewBindingHelper.h"
#import "FavorListNetRespondBean.h"

@interface OrdersViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *noResultLogoImageView;
@property (weak, nonatomic) IBOutlet UITableView *ordersListView;

@property (nonatomic, strong) OrdersViewModel *viewModel;
@end

@implementation OrdersViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  self.viewModel = [[OrdersViewModel alloc] init];
  
  // 显示 网络等待提示框
  [self.viewModel.requestOrderListCommand.executing subscribeNext:^(NSNumber *isExecuting) {
    if (isExecuting.boolValue) {
      [SimpleProgressBar show];
    } else {
      [SimpleProgressBar dismiss];
    }
  }];
  
  // 如果拉取用户收藏列表失败的话, 就隐藏ListView控件
  RAC(self.ordersListView, hidden) = [self.viewModel.requestOrderListCommand.errors map:^id(id value) {
    return @YES;
  }];
  
  RAC(self.noResultLogoImageView, hidden) = [RACObserve(self.ordersListView, hidden) not];
  
  [self.viewModel.requestOrderListCommand.errors subscribeNext:^(NSError *error) {
    [SimpleToast showWithText:error.localizedDescription duration:1.5f];
  }];
  
  UINib *nib = [UINib nibWithNibName:@"FavoritTableViewCell" bundle:nil];
  [CETableViewBindingHelper bindingHelperForTableView:self.ordersListView
                                         sourceSignal:RACObserve(self.viewModel, cellViewModelList)
                                     selectionCommand:nil
                                         templateCell:nib].delegate = self;

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return  UITableViewCellEditingStyleDelete;
}

@end
