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

@interface ViewController () <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UIButton *mButton;
@property (nonatomic, weak) NSString *searchText;
@property (nonatomic, weak) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

{
    int pn;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //searchBar
    self.searchBar.delegate = self;
    self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"aa",@"bb",@"cc",nil];
    [self.navigationItem.titleView addSubview:self.searchBar];
    
    
    //tableView
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview: self.tableView];
    [self.tableView reloadData];
    
    
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
                              NSLog(@"！！！！！！responseObject==%@",responseObject);
                              if (pn == 0) {
                                  _dataSource = [foodMenu mj_objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"result"]objectForKey:@"data"]];
                                  NSLog(@"@@@@@@@_dataSource==%@",_dataSource);
                              }else{
                                  NSArray* arry=[foodMenu mj_objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"result"] objectForKey:@"data"]];
                                  NSLog(@"@@@@@@@_dataSource==%@",_dataSource);
                                  [_dataSource addObjectsFromArray:arry];
                              }
                              
                          }
                      } Failure:^(NSError *error) {
                          NSLog(@"error%@",error.description);
                      }];
    
}

-(IBAction)pressedButton:(id)sender{
    
//    NSLog(@"search text:%@",self.searchBar.text);
//    
//    //    [searchBar resignFirstResponder];
//    _searchText = self.searchBar.text;
//    pn=0;
//    [self getDataBySearchText];
//    
}

#pragma mark - UISearchBarDelegate 
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBar`s search text:%@",self.searchBar.text);
    _searchText = self.searchBar.text;
    pn=0;
    [self getDataBySearchText];

}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
    /**
     设置搜索栏的“cancel”按钮为中文“取消”
     遍历所有子view，获取到UINavigationButton这个类，虽然不能调用UINavigationButton这个类，但是我们清楚它继承了UIButton，所以我们可以取到并更改它。
     */
    for (UIView *subview in [[self.searchBar.subviews firstObject]subviews]) {
//        NSLog(@"<<<<<<<<<<<<%@",subview);
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subview;
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [btn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}


#pragma mark - UITableViewDelegate



#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    return cell;
}


@end
