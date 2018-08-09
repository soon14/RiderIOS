//
//  PutForwardDetailViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/11.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "PutForwardDetailViewController.h"
#import "ForwardIconTableViewCell.h"
#import "BankinfoTableViewCell.h"
#import "ForwardScheduleTableViewCell.h"
#import "ForwardOrderTableViewCell.h"



static NSString *const orderCellIndentifier = @"ForwardOrderTableViewCell";
static NSString *const iconCellIndentifier = @"ForwardIconTableViewCell";
static NSString *const bankCellIndentifier = @"BankinfoTableViewCell";
static NSString *const scheduleCellIndentifier = @"ForwardScheduleTableViewCell";


@interface PutForwardDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    
}

@property(nonatomic,weak)IBOutlet UITableView *listView;
@property (nonatomic,strong) NSArray * bankinfoList;
@property (nonatomic,strong) NSArray * bankkeyList;
@property (nonatomic,strong) NSArray * orderTitleList;
@property (nonatomic,strong) NSArray * orderKeyList;
@end

@implementation PutForwardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self.listView registerNib:[UINib nibWithNibName:@"ForwardOrderTableViewCell" bundle:nil] forCellReuseIdentifier:orderCellIndentifier];
    
    [self.listView registerNib:[UINib nibWithNibName:@"ForwardIconTableViewCell" bundle:nil] forCellReuseIdentifier:iconCellIndentifier];
    
    [self.listView registerNib:[UINib nibWithNibName:@"BankinfoTableViewCell" bundle:nil] forCellReuseIdentifier:bankCellIndentifier];
    
     [self.listView registerNib:[UINib nibWithNibName:@"ForwardScheduleTableViewCell" bundle:nil] forCellReuseIdentifier:scheduleCellIndentifier];
    
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSArray *)bankinfoList{
    
    if (!_bankinfoList) {
        _bankinfoList = [[NSArray alloc] initWithObjects:@"提现到",@"提现金额",@"提现手续费", nil];
    }
    return _bankinfoList;
}

-(NSArray *)bankkeyList{
    
    if (!_bankkeyList) {
        _bankkeyList = [[NSArray alloc] initWithObjects:@"中国银行（尾号0699）",@"199.06元",@"1.00元", nil];
    }
    return _bankkeyList;
}

-(NSArray *)orderTitleList{
    
    if (!_orderTitleList) {
        _orderTitleList = [[NSArray alloc] initWithObjects:@"创建时间",@"银行订单号",nil];
    }
    return _orderTitleList;
}

-(NSArray *)orderKeyList{
    
    if (!_orderKeyList) {
        _orderKeyList = [[NSArray alloc] initWithObjects:@"2018-07-05  15:09",@"000000888888", nil];
    }
    return _orderKeyList;
}

#pragma mark - UItableView delegate
//设置表头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
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
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return self.bankinfoList.count;
    }
    else if (section == 2) {
        return self.orderTitleList.count;
    }
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 220;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        ForwardIconTableViewCell *cell = (ForwardIconTableViewCell *)[tableView dequeueReusableCellWithIdentifier:iconCellIndentifier];
        
        if (cell == nil)
        {
            cell = [[ForwardIconTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:iconCellIndentifier];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 1) {
        
        BankinfoTableViewCell *cell = (BankinfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:bankCellIndentifier];
        
        if (cell == nil)
        {
            cell = [[BankinfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:bankCellIndentifier];
        }
        
        [cell setData:self.bankinfoList[indexPath.row] key:self.bankkeyList[indexPath.row] withIndexRow:indexPath.row];
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        ForwardOrderTableViewCell *cell = (ForwardOrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:orderCellIndentifier];
        
        if (cell == nil)
        {
            cell = [[ForwardOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:orderCellIndentifier];
        }
        
        [cell setData:self.orderTitleList[indexPath.row] key:self.orderKeyList[indexPath.row]];
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
//    ForwardScheduleTableViewCell *cell = (ForwardScheduleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:scheduleCellIndentifier];
//
//    if (cell == nil)
//    {
//        cell = [[ForwardScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                                   reuseIdentifier:scheduleCellIndentifier];
//    }
//
//    cell.backgroundColor = [UIColor whiteColor];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
    //
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
