//
//  OrderDetailViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderdDetailTableViewCell.h"
#import "GrabHeaderView.h"
#import "TitleHeaderView.h"
#import "OrderDetailTableViewCell.h"
#import "OrderInfoTableViewCell.h"
#import "StatusTimeTableViewCell.h"
#import "OrderDetailMode.h"

static NSString *const detailCellIndentifier = @"OrderdDetailTableViewCell";
static NSString *const orderDetailCellIndentifier = @"OrderDetailTableViewCell";
static NSString *const orderInfoCellIndentifier = @"OrderInfoTableViewCell";
static NSString *const statusCellIndentifier = @"StatusTimeTableViewCell";


@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSArray *infoArr;
    NSMutableArray *detailArr;
    NSMutableArray *incomeArr;
    GrabHeaderView *headerView;
    
}
@property(nonatomic,weak)IBOutlet UITableView *orderDetailListView;
@end

@implementation OrderDetailViewController
@synthesize orderStatus;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([orderStatus isEqualToString:@"settlementing"]) {
        
         incomeArr = [[NSMutableArray alloc]initWithObjects:@"本单收入",@"",nil];
    }
    else
    {
       
        incomeArr = [[NSMutableArray alloc]initWithObjects:@"商圈奖励",@"优质单奖励",@"违规取餐",@"违规送餐",@"本单收入",@"",nil];
        if ([orderStatus isEqualToString:@"granting"]) {
            
            UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
            //[leftbutton setBackgroundColor:[UIColor blackColor]];
            [rightbutton setTitle:@"申诉" forState:UIControlStateNormal];
            [rightbutton setFont:[UIFont systemFontOfSize:17]];
            [rightbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
            [rightbutton addTarget:self action:@selector(appealPress) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem=rightitem;
            
        }
    }
    
   
    
    infoArr = [[NSArray alloc]initWithObjects:@"订单编号",@"期望送达",@"发票",@"备注信息",nil];
    detailArr = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray *nameArr = [[NSArray alloc]initWithObjects:@"燕麦面包",@"法式长棍",@"甜甜圈",@"汉堡",@"配送费",@"餐盒费",@"63.30", nil];
    NSArray *numArr = [[NSArray alloc]initWithObjects:@"1",@"2",@"1",@"3",@"1",@"",@"", nil];
    NSArray *moneyArr = [[NSArray alloc]initWithObjects:@"20.00",@"16.00",@"20.30",@"25.00", @"16.00",@"20.30",@"25.00",nil];
    
    for (int i = 0; i< [nameArr count]; i ++) {
        OrderDetailMode *mode = [[OrderDetailMode alloc]init];
        mode.name = [nameArr objectAtIndex:i];
        mode.num = [numArr objectAtIndex:i];
        mode.money = [moneyArr objectAtIndex:i];
        [detailArr addObject:mode];
    }
    
    headerView = [GrabHeaderView defaultView];
    
    [self.orderDetailListView registerNib:[UINib nibWithNibName:@"OrderdDetailTableViewCell" bundle:nil] forCellReuseIdentifier:detailCellIndentifier];
    [self.orderDetailListView registerNib:[UINib nibWithNibName:@"OrderDetailTableViewCell" bundle:nil] forCellReuseIdentifier:orderDetailCellIndentifier];
    [self.orderDetailListView registerNib:[UINib nibWithNibName:@"OrderInfoTableViewCell" bundle:nil] forCellReuseIdentifier:orderInfoCellIndentifier];
    [self.orderDetailListView registerNib:[UINib nibWithNibName:@"StatusTimeTableViewCell" bundle:nil] forCellReuseIdentifier:statusCellIndentifier];
    
    self.orderDetailListView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)appealPress
{
    [self performSegueWithIdentifier:@"goAppeal" sender:nil];
}

#pragma mark - UItableView delegate
//设置表头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 150;
    }
    else if (section == 4) {
        return 10;
    }
    else
    {
        return 35;
    }
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
    
    if (section == 0) {
        [headerView isHiddenView];
        return headerView;
    }
    else
    {
        TitleHeaderView *view= [TitleHeaderView defaultView];
        if (section == 1) {
            view.titleLbl.text = @"收入详情";
            
        }
        else if (section == 2) {
            view.titleLbl.text = @"订单详情";
            
        }
        else if (section == 3) {
            view.titleLbl.text = @"订单信息";
        }
        else
        {
            view.titleLbl.text = @"";
        }
        return view;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else if (section == 1) {
       
         return [incomeArr count];
    }
    else if (section == 2) {
         return [detailArr count];
        
    }
    else if (section == 3) {
       return [infoArr count];
    }
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if(indexPath.section == 1)
    {
        if (indexPath.row == [incomeArr count]-1) {
            
             return 84;
        }
       return 40;
    }
    else if(indexPath.section == 4)
    {
        return 80;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        OrderdDetailTableViewCell *cell = (OrderdDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:detailCellIndentifier];
        
        if (cell == nil)
        {
            cell = [[OrderdDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:detailCellIndentifier];
        }
        
        [cell setData:incomeArr index:indexPath.row withStatus:orderStatus];
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 2)
    {
        OrderDetailTableViewCell *cell = (OrderDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:orderDetailCellIndentifier];
        
        if (cell == nil)
        {
            cell = [[OrderDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:orderDetailCellIndentifier];
        }
        
        [cell setData:detailArr count:[detailArr count] index:indexPath.row withIsLast:true];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 3)
    {
        OrderInfoTableViewCell *cell = (OrderInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:orderInfoCellIndentifier];
        
        if (cell == nil)
        {
            cell = [[OrderInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:orderInfoCellIndentifier];
        }
        [cell setTitle:[infoArr objectAtIndex:indexPath.row] withData:@""];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    StatusTimeTableViewCell *cell = (StatusTimeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:statusCellIndentifier];
    
    if (cell == nil)
    {
        cell = [[StatusTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:statusCellIndentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        //        [self performSegueWithIdentifier:@"ToMineInfo" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    typeStr = @"";
    //    if([segue.identifier isEqualToString:@"PayToCoupon"]){
    //        QQKCouponViewController *couponCtr = segue.destinationViewController;
    //        couponCtr.delegate = self;
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
