//
//  PayViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/15.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "PayViewController.h"
#import "PayTypeTableViewCell.h"
#import "PayMoneyTableViewCell.h"

static NSString *const typeCellIndentifier = @"PayTypeTableViewCell";
static NSString *const moneyCellIndentifier = @"PayMoneyTableViewCell";

@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *typeArr;
    NSArray *iconArr;
    NSInteger selectIndex;
}
@property(nonatomic,weak)IBOutlet UITableView *payTableView;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    selectIndex = 11;
    
    typeArr = [[NSArray alloc]initWithObjects:@"微信支付",@"支付宝支付", nil];
    iconArr = [[NSArray alloc]initWithObjects:@"weix",@"zfb", nil];
    
    [self.payTableView registerNib:[UINib nibWithNibName:@"PayTypeTableViewCell" bundle:nil] forCellReuseIdentifier:typeCellIndentifier];
    [self.payTableView registerNib:[UINib nibWithNibName:@"PayMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:moneyCellIndentifier];
    self.payTableView.scrollEnabled = NO;
}

#pragma mark - UItableView delegate
//设置表头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01f;
    }
    return 10;
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
    
    
    return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return [typeArr count];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        PayMoneyTableViewCell *cell = (PayMoneyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:moneyCellIndentifier];
        
        if (cell == nil)
        {
            cell = [[PayMoneyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:moneyCellIndentifier];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    PayTypeTableViewCell *cell = (PayTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:typeCellIndentifier];
    
    if (cell == nil)
    {
        cell = [[PayTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:typeCellIndentifier];
    }

    [cell selectType:selectIndex];
    
    [cell setTitle:typeArr[indexPath.row] image:iconArr[indexPath.row] withIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    //
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        selectIndex = indexPath.row;
        [self.payTableView reloadData];
    }
   
//    [self performSegueWithIdentifier:@"goCash" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //    if([segue.identifier isEqualToString:@"goOrderDetail"]){
    //        OrderDetailViewController *detailCtr = segue.destinationViewController;
    //        detailCtr.orderStatus = statusStr;
    //    }
    
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
