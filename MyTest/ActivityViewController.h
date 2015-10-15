//
//  ActivityView.h
//  TestDemo
//
//  Created by Heyz赫兹 on 15/10/12.
//  Copyright © 2015年 Heyz赫兹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWaterFlowLayout.h"

@interface ActivityViewController: UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,LinWaterFlowLayoutDelegate,UIScrollViewDelegate>

@property(retain,nonatomic)  UIScrollView *scrollView;

@property(strong,nonatomic) NSMutableArray *dataSource;//数据源
@end
