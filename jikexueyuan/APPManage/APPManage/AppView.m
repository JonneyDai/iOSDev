//
//  AppView.m
//  APPManage
//
//  Created by JonneyDai on 16/6/14.
//  Copyright © 2016年 JonneyDai. All rights reserved.
//

#import "AppView.h"
#import "AppInfo.h"

@interface AppView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation AppView
- (IBAction)downloadBtnOnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(downloadClickWithBtn:)]) {
        [self.delegate downloadClickWithBtn:sender];
    }
    
}

+(instancetype)appView{
    return  [[[NSBundle mainBundle]loadNibNamed:@"AppView" owner:nil options:nil]lastObject];
}

-(void)setAppInfo:(AppInfo *)appInfo{
    _appInfo = appInfo;
    self.iconView.image = appInfo.image;
    self.nameLabel.text = appInfo.name;
}

@end
