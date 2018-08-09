//
//  CancelDetailViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/8.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "CancelDetailViewController.h"
#import "CancelHeaderView.h"
#import "CancelTableViewCell.h"
#import "StatusTimeTableViewCell.h"
#import "TitleHeaderView.h"

static NSString *const cancelCellIndentifier = @"CancelTableViewCell";
static NSString *const timeCellIndentifier = @"StatusTimeTableViewCell";

@interface CancelDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
   
}
@property(nonatomic,weak)IBOutlet UITableView *cancelListView;
@end

@implementation CancelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.cancelListView registerNib:[UINib nibWithNibName:@"CancelTableViewCell" bundle:nil] forCellReuseIdentifier:cancelCellIndentifier];
    
    [self.cancelListView registerNib:[UINib nibWithNibName:@"StatusTimeTableViewCell" bundle:nil] forCellReuseIdentifier:timeCellIndentifier];
    
    self.cancelListView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UItableView delegate
//设置表头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 174;
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
    if (section == 0) {
        CancelHeaderView *headerView = [CancelHeaderView defaultView];
        return headerView;
    }
    else
    {
        TitleHeaderView *headerView = [TitleHeaderView defaultView];
        headerView.titleLbl.text = @"";
        return headerView;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 95;
    }
    else
    {
        return 80;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CancelTableViewCell *cell = (CancelTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cancelCellIndentifier];
        
        if (cell == nil)
        {
            cell = [[CancelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:cancelCellIndentifier];
        }
    
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        StatusTimeTableViewCell *cell = (StatusTimeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:timeCellIndentifier];
        
        if (cell == nil)
        {
            cell = [[StatusTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:timeCellIndentifier];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [self performSegueWithIdentifier:@"goCancelDetail" sender:nil];

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
