//
//  ActivityView.m
//  TestDemo
//
//  Created by Heyz赫兹 on 15/10/12.
//  Copyright © 2015年 Heyz赫兹. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityViewCell.h"
#import "DetailActivityView.h"
#define screenHeight [[UIScreen mainScreen]bounds].size.height //屏幕高度
#define screenWidth [[UIScreen mainScreen]bounds].size.width   //屏幕宽度
#define colletionCell 2
@interface ActivityViewController ()
{
    NSMutableArray *hrr;
    
    UISegmentedControl *_seg;
}
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HEYZ";
    self.view.backgroundColor=[UIColor whiteColor];
    //scrollview 下面
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, screenWidth, screenHeight-60)];
    _scrollView.delegate=self;
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.pagingEnabled=YES;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.contentSize=CGSizeMake(screenWidth*3, screenHeight-60);
    [self.view addSubview: _scrollView];
    
    //这是存储活动的数据源，不只一个数组
    hrr=[[NSMutableArray alloc]init];
    //self.view.backgroundColor=[UIColor greenColor];
    
    LinWaterFlowLayout *layout = [[LinWaterFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 10);
    layout.delegate = self;
    
//    UICollectionViewFlowLayout *flowout=[[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-120) collectionViewLayout:layout];
    collectionView.backgroundColor=[UIColor lightGrayColor];
    collectionView.dataSource=self;
    collectionView.delegate=self;
    [collectionView registerNib:[UINib nibWithNibName:@"ActivityViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [ _scrollView addSubview:collectionView];
    
    NSArray *segmentTitles=@[@"附近",@"热点",@"其他"];
    _seg=[[UISegmentedControl alloc]initWithItems:segmentTitles];
    [_seg setFrame:CGRectMake(0, 60, screenWidth, 40)];
    _seg.selectedSegmentIndex=0;
    [_seg addTarget:self action:@selector(ChangePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_seg];
}

//点击segment 切换状态
-(void)ChangePage:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
            //附近
        case 0:
            [ _scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
        case 1:
            //热点
            [ _scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:YES];
            break;
            
        case 2:
            [ _scrollView setContentOffset:CGPointMake(screenWidth*2, 0) animated:YES];
            break;
        default:
            break;
            
    }
}

//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat height=80+(arc4random()%120);
//    
//    NSLog(@"cell size -> %@",NSStringFromCGSize(CGSizeMake(screenWidth/colletionCell-8, height)));
//    return  CGSizeMake(screenWidth/colletionCell-8, height);  //设置cell宽高
//}
////定义每个Section 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
//}
//
#pragma mark - collection data source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //event counts
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //static NSString *cellin=@"cell";
    ActivityViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((20 * indexPath.row) % 255)/255.0 green:((50 * indexPath.row)%255)/255.0 blue:((70 * indexPath.row)%255)/255.0 alpha:1.0f];

    cell.imageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",indexPath.row]];
    return cell;
}

#pragma mark - collection delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    DetailActivityView *DView=[[DetailActivityView alloc]init];
    [self presentViewController:DView animated:YES completion:^{
        NSLog(@"did select item");
    }];

    [DView setImage:indexPath.row];
}

#pragma mark - scroll view delegate
//change segment statues
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ( _scrollView==scrollView) {
        int page= _scrollView.contentOffset.x/screenWidth;
        _seg.selectedSegmentIndex=page;
    }
    
}

#pragma mark - l water flow layout delegate
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(LinWaterFlowLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row % 2 == 0){
        return 240;
    }
    return  300;//-(arc4random()%100);
    //get the item height

}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(LinWaterFlowLayout *)collectionViewLayout eachColumnStartingY:(NSUInteger)column
{
    return 0;
}

- (void)makeSomeImages
{
    
}

- (void)loadData
{
    AVQuery *eventsQuery = [AVQuery queryWithClassName:@"Event"];
    [eventsQuery whereKey:@"end_time" greaterThanOrEqualTo:@"现在的时间"];
    if(_dataSource){
        //添加内容到data source
        [_dataSource addObjectsFromArray:[eventsQuery findObjects]];
    }else{
        _dataSource = [NSMutableArray arrayWithArray:[eventsQuery findObjects]];
    }
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
