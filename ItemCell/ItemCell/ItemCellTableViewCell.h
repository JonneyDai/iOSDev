//
//  ItemCellTableViewCell.h
//  ItemCell
//
//  Created by 代隽杰 on 16/1/13.
//  Copyright © 2016年 gree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
