//
//  AppView.m
//  AppManage
//
//  Created by 代隽杰 on 16/6/23.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "AppView.h"
#import "AppInfo.h"

@interface AppView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation AppView

- (IBAction)downloadOnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(downloadClickWithBtn:)]) {
        [self.delegate downloadClickWithBtn:sender];
    }
}

+(instancetype)initWithAppView{
    return [[[NSBundle mainBundle]loadNibNamed:@"AppView" owner:nil options:nil]lastObject];
}

-(void)setAppInfo:(AppInfo *)appInfo{
    _appInfo = appInfo;
    self.iconView.image = appInfo.image;
    self.nameLabel.text = appInfo.name;
}

@end
