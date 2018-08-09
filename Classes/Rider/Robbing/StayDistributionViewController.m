//
//  StayDistributionViewController.m
//  RiderIOS
//
//  Created by Han on 2018/6/4.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "StayDistributionViewController.h"
#import "StayDistributionTableViewCell.h"
#import "GrabViewController.h"

static NSString *const listCellIndentifier = @"StayDistributionTableViewCell";

@interface StayDistributionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *listArr;
}
@property(nonatomic,strong) UITableView *m_listTaleView;
@end

@implementation StayDistributionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.m_listTaleView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.m_listTaleView =  [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.m_listTaleView.dataSource = self;
    self.m_listTaleView.delegate = self;
    self.m_listTaleView.sectionFooterHeight = 0;
    self.m_listTaleView.sectionHeaderHeight = 0;
    //    self.m_listTaleView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:self.m_listTaleView];
    [self.m_listTaleView registerNib:[UINib nibWithNibName:@"StayDistributionTableViewCell" bundle:nil] forCellReuseIdentifier:listCellIndentifier];
    self.m_listTaleView.separatorStyle = UITableViewCellSelectionStyleNone;
    //    self.m_listTaleView.backgroundColor = [UIColor colorWithHexString:@"eff3f8"];
    
    listArr = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",nil];
    
    if (KIsiPhoneX) {
        self.m_listTaleView.sd_layout
        .rightSpaceToView(self.view, 0)
        .leftSpaceToView(self.view, 0)
        .topSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, 170);
    }
    else
    {
        self.m_listTaleView.sd_layout
        .rightSpaceToView(self.view, 0)
        .leftSpaceToView(self.view, 0)
        .topSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, 114);
    }
}

#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [listArr count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    //    if (section == 0) {
    //        return 0.1f;
    //    }
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //    return 12;//这个方法不写，或者return 0跟return 12的效果一样
    return 0.1f;//把高度设置很小，效果可以看成footer的高度等于0
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StayDistributionTableViewCell *cell = (StayDistributionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:listCellIndentifier];
    
    if (cell == nil)
    {
        cell = [[StayDistributionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:listCellIndentifier];
    }
    [cell setType:@"Stay" indexPath:indexPath withData:@""];

    cell.didContactButton = ^(NSInteger idx) {
        NSLog(@"Contactidx == %lu",idx);
    };
    
    cell.didStatusButton = ^(NSInteger idx) {
         NSLog(@"Statusidx == %lu",idx);
    };
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
    GrabViewController *detailVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"GrabViewController"];
    detailVC.grabType = @"stay";
    detailVC.hidesBottomBarWhenPushed = YES;
    //    detailVC.entranceStr = @"派单中";
    [self.navigationController pushViewController:detailVC animated:YES];
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
