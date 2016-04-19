//
//  ViewController.m
//  FoodTest
//
//  Created by 代隽杰 on 16/4/19.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ViewController.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "foodMenu.h"
#import "ConstFile.h"
#import <MJExtension/MJExtension.h>

@interface ViewController () <UISearchBarDelegate>

@property (nonatomic,strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UIButton *mButton;
@property (nonatomic, weak) NSString *searchText;
@property (nonatomic, weak) NSMutableArray *dataSource;
@end

@implementation ViewController

{
    int pn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)getDataBySearchText{
    JHAPISDK *jhapi = [JHAPISDK shareJHAPISDK];
    NSDictionary *parms= @{@"menu":_searchText,
                           @"pn":[NSString stringWithFormat:@"%d",pn],
                           @"rn":@"30"};
    [jhapi executeWorkWithAPI:API_query
                        APIID:APPID
                   Parameters:parms
                       Method:Method_Get
                      Success:^(id responseObject) {
                          int error_code = [[responseObject objectForKey:@"error_code"]intValue];
                          if (!error_code) {
                              NSLog(@"%@",responseObject);
                              if (pn == 0) {
                                  _dataSource = [foodMenu mj_objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"result"]objectForKey:@"data"]];
                              }else{
                                  NSArray* arry=[foodMenu mj_objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"result"] objectForKey:@"data"]];
                                  
                                  [_dataSource addObjectsFromArray:arry];
                              }
                              
                          }
                      } Failure:^(NSError *error) {
                          NSLog(@"error%@",error.description);
                      }];
    
}

-(IBAction)pressedButton:(id)sender{
    
}

#pragma mark - UISearchBarDelegate 
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"search text:%@",searchBar.text);

//    [searchBar resignFirstResponder];
    _searchText=searchBar.text;
    pn=0;
    [self getDataBySearchText];

}



@end
