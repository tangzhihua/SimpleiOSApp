
#import "FavoritesViewController.h"
#import "FavoritesViewModel.h"
#import "SimpleProgressBar.h"
#import "SimpleToast.h"
#import "CETableViewBindingHelper.h"
#import "FavorListNetRespondBean.h"

@interface FavoritesViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *noResultLogoImageView;
@property (weak, nonatomic) IBOutlet UITableView *favoritesListView;

@property (nonatomic, strong) FavoritesViewModel *viewModel;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  self.viewModel = [[FavoritesViewModel alloc] init];
  
  // 显示 网络等待提示框
  [self.viewModel.requestFavorListCommand.executing subscribeNext:^(NSNumber *isExecuting) {
    if (isExecuting.boolValue) {
      [SimpleProgressBar show];
    } else {
      [SimpleProgressBar dismiss];
    }
  }];
  
  // 如果拉取用户收藏列表失败的话, 就隐藏ListView控件
  RAC(self.favoritesListView, hidden) = [self.viewModel.requestFavorListCommand.errors map:^id(id value) {
    return @YES;
  }];
  
  RAC(self.noResultLogoImageView, hidden) = [RACObserve(self.favoritesListView, hidden) not];
  
  [self.viewModel.requestFavorListCommand.errors subscribeNext:^(NSError *error) {
    [SimpleToast showWithText:error.localizedDescription duration:1.5f];
  }];
  
  UINib *nib = [UINib nibWithNibName:@"FavoritTableViewCell" bundle:nil];
  [CETableViewBindingHelper bindingHelperForTableView:self.favoritesListView
                                         sourceSignal:RACObserve(self.viewModel, cellViewModelList)
                                selectionCommandArray:@[self.viewModel.favorListViewSelectedCommand]
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
