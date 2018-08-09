//
//  OrderViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/4.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderHeaderView.h"
#import "OrderTableViewCell.h"
#import "OrderDetailViewController.h"
#import "GridScreenView.h"

static NSString *const orderCellIndentifier = @"OrderTableViewCell";

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSArray *infoArr;
    NSMutableArray *detailArr;
    NSString *statusStr;
    NSMutableArray *mothArr;
}
@property(nonatomic,weak)IBOutlet UITableView *orderListView;
@property(nonatomic,strong)GridScreenView *historyView;
@end

@implementation OrderViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    mothArr = [[NSMutableArray alloc]initWithObjects:@"6月",@"5月",@"4月",@"3月",@"2月",@"1月",nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self.orderListView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:orderCellIndentifier];
    
     self.orderListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.historyView = [[GridScreenView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height-50)];

    __weak typeof(self) weakSelf = self;
    self.historyView.didSelectView = ^(NSInteger idx){
        id sself = weakSelf;
        if(sself){
            NSLog(@"index == %lu",idx);
        }
    };
    
    self.historyView.didHiddenView = ^(NSString *str){
        id sself = weakSelf;
        if(sself){
            weakSelf.historyView.hidden = YES;
        }
    };
    
    self.historyView.hidden = YES;
    [self.view addSubview:self.historyView];
}

- (IBAction)historyView:(id)sender
{
    self.historyView.monthArr = mothArr;
      self.historyView.hidden = NO;
}

#pragma mark - UItableView delegate
//设置表头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OrderHeaderView *headerView = [OrderHeaderView defaultView];

    return headerView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    OrderTableViewCell *cell = (OrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:orderCellIndentifier];
    
    if (cell == nil)
    {
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:orderCellIndentifier];
    }
    [cell setIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        statusStr = @"settlementing";//结算中
        [self performSegueWithIdentifier:@"goOrderDetail" sender:nil];
    }
    else if (indexPath.row == 1) {
        statusStr = @"granting";//发放
        [self performSegueWithIdentifier:@"goOrderDetail" sender:nil];
    }
    else if (indexPath.row == 2) {
        statusStr = @"examining";//审核中
        [self performSegueWithIdentifier:@"goOrderDetail" sender:nil];
    }
    else if (indexPath.row == 3) {
        statusStr = @"examined";//已审核
        [self performSegueWithIdentifier:@"goOrderDetail" sender:nil];
    }
    else
    {
        statusStr = @"cancel";//取消
        
        [self performSegueWithIdentifier:@"goCancelDetail" sender:nil];
    }
    
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        if([segue.identifier isEqualToString:@"goOrderDetail"]){
            OrderDetailViewController *detailCtr = segue.destinationViewController;
            detailCtr.orderStatus = statusStr;
        }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
