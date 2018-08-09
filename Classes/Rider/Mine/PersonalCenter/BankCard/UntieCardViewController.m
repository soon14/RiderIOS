//
//  UntieCardViewController.m
//  RiderIOS
//
//  Created by Han on 2018/7/6.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "UntieCardViewController.h"
#import "UntieCardTableViewCell.h"

static NSString *const cellIndentifier = @"UntieCardTableViewCell";

@interface UntieCardViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *keyArr;
@property (nonatomic, strong) IBOutlet UITableView *cardInfoTableView;
@end

@implementation UntieCardViewController

// 数据数组的懒加载
-(NSArray *)titleArr
{
    if (_titleArr == nil) {
        _titleArr = [NSArray arrayWithObjects:@"开户银行",@"开户人",@"银行卡卡号",nil];
    }
    return _titleArr;
}

-(NSArray *)keyArr
{
    if (_keyArr == nil) {
        _keyArr = [NSArray arrayWithObjects:@"中国银行储蓄卡",@"赵*勇",@"****  ****  ****  6420",nil];
    }
    return _keyArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.cardInfoTableView registerNib:[UINib nibWithNibName:@"UntieCardTableViewCell" bundle:nil] forCellReuseIdentifier:cellIndentifier];
    self.cardInfoTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.cardInfoTableView.scrollEnabled = NO;
}

- (IBAction)untieCardPress:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定要解除绑定吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.titleArr count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 10)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    return headerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //    return 12;//这个方法不写，或者return 0跟return 12的效果一样
    return 0.1f;//把高度设置很小，效果可以看成footer的高度等于0
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UntieCardTableViewCell *cell = (UntieCardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil)
    {
        cell = [[UntieCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:cellIndentifier];
    }
    
    [cell setData:self.titleArr[indexPath.row] indexRow:indexPath.row withName:self.keyArr[indexPath.row]];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[self performSegueWithIdentifier:@"goUntieCard" sender:nil];
    
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
