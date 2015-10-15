//
//  mycell.h
//  MyTest
//
//  Created by Heyz赫兹 on 15/10/12.
//  Copyright © 2015年 Heyz赫兹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityViewCell : UICollectionViewCell
//广告图
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
//描述
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
//点赞的数目label
@property (weak, nonatomic) IBOutlet UILabel *like;
//成员数目lable
@property (weak, nonatomic) IBOutlet UILabel *memberNum;

@end
