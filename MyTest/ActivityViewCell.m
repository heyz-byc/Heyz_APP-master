//
//  mycell.m
//  MyTest
//
//  Created by Heyz赫兹 on 15/10/12.
//  Copyright © 2015年 Heyz赫兹. All rights reserved.
//

#import "ActivityViewCell.h"

@implementation ActivityViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.cornerRadius = 8;
    self.imageview.contentMode = UIViewContentModeScaleAspectFill;

}

@end
