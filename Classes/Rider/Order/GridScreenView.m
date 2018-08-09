//
//  GridScreenView.m
//  RiderIOS
//
//  Created by Han on 2018/6/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "GridScreenView.h"
#import "GridScreenCollectionViewCell.h"

@interface GridScreenView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *selectArr;
    NSInteger indexRow;
}
@property(nonatomic,strong) IBOutlet UIImageView *backgoundView;
@property(nonatomic,strong) IBOutlet UICollectionView *m_monthCollectionView;
@end

static NSString *const gridCellIndentifier = @"GridScreenCollectionViewCell";
@implementation GridScreenView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        NSArray *nibs=[[NSBundle mainBundle]loadNibNamed:@"GridScreenView" owner:nil options:nil];
        self=[nibs objectAtIndex:0];
        self.frame = frame;
        self.backgoundView.userInteractionEnabled = YES;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumInteritemSpacing = 0;
        self.m_monthCollectionView.collectionViewLayout = flowLayout;
        self.m_monthCollectionView.backgroundColor = [UIColor whiteColor];
        [self.m_monthCollectionView registerNib:[UINib nibWithNibName:@"GridScreenCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:gridCellIndentifier];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] == self.backgoundView)
    {
        //do some method.....
        if(self.didHiddenView){
            self.didHiddenView(@"");
        }
    }
    
}

- (void)setMonthArr:(NSMutableArray *)monthArr
{
    indexRow = 10;
    
    selectArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    selectArr = monthArr;
    [self.m_monthCollectionView reloadData];
}


#pragma mark - collectionView delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [selectArr count];
    
}

//item上下间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 10;
    
}

//-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    CGSize size = {K_SCREENWIDTH_ios, 60};
//    return size;
//}

//设置sectionHeader | sectionFoot
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//
//    UICollectionReusableView *headerViews = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
//    UIView *view = [[UIView alloc]init];
//
//    view.frame = CGRectMake(0, 0, K_SCREENWIDTH_ios, 60);
//    [headerView setFrame:view.frame];
//    [view addSubview:headerView];
//
//    [headerViews addSubview:view];
//    return headerViews;
//
//
//}

//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    if (section == 0) {
    if(K_SCREENWIDTH_ios == 320.0)
    {
        UIEdgeInsets top = {15,15,15,15};
        return top;
        
    }
    else
    {
        UIEdgeInsets top = {15,15,15,15};
        return top;
    }
}

//设置元素大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(60*K_SCREENSCALE, 30*K_SCREENSCALE);

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GridScreenCollectionViewCell *cell = (GridScreenCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:gridCellIndentifier forIndexPath:indexPath];
    cell.indexRow = indexPath.row;
    [cell setData:[selectArr objectAtIndex:indexPath.row] withIndex:indexRow];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    indexRow = indexPath.row;
    
    if(self.didSelectView){
        self.didSelectView(indexPath.row);
    }
    
    [collectionView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
