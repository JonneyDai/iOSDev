//
//  ItemsTableViewController.m
//  Homepwner
//
//  Created by 代隽杰 on 16/1/5.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "ItemsTableViewController.h"
#import "BNRItem.h"
#import "ItemStore.h"
#import "DetailViewController.h"
#import "ItemCellTableViewCell.h"

@interface ItemsTableViewController ()

//@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation ItemsTableViewController

-(IBAction)addNewItem:(id)sender
{
    //创建新的BNRItem对象，并将其加入ItemStore对象；
    BNRItem *newItem = [[ItemStore sharedStore]createItem];
    NSInteger lastRow = [[[ItemStore sharedStore]allItems]indexOfObject:newItem];
    
    //创建NSIndexPath对象，代表的位置是：第一个表格段，最后一个表格行
//    NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    //将新行插入UITabelView对象
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}
//
//-(IBAction)toggleEditintMode:(id)sender
//{
//    if (self.isEditing) {
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        [self setEditing:NO animated:YES];
//    }else{
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        [self setEditing:YES animated:YES];
//    }
//}

-(instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
//        for (int i = 0; i < 5 ; i++) {
//            [[ItemStore sharedStore]createItem];
//        }
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                            target:self
                                                                            action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = bbi;
        
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    
    return self;
}

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    //创建UINib对象，该对象代表包含了ItemCellTableViewCell的NIB文件
    UINib *nib = [UINib nibWithNibName:@"ItemCellTableViewCell" bundle:nil];
    
    //通过UINib对象注册相应的NIB文件
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ItemCellTableViewCell"];
    
//    UIView *header = self.headerView;
//    [self.tableView setTableHeaderView:header];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(UIView *) headerView
//{
//    //如果还没有加载headerview
//    if (!_headerView) {
//        [[NSBundle mainBundle]loadNibNamed:@"HeaderView"
//                                     owner:self
//                                   options:nil];
//    }
//    return  _headerView;
//}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [[[ItemStore sharedStore]allItems]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
//                                                  reuseIdentifier:@"UITableViewCell"];
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
//                                                            forIndexPath:indexPath];
    
    //获取ItemCellTableViewCell对象，返回的可能是现有的对象，也可能是新建的对象
    ItemCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCellTableViewCell"
                                                                  forIndexPath:indexPath];
    NSArray *items = [[ItemStore sharedStore]allItems];
    BNRItem *item = items[indexPath.row];
    
    //根据BNRItem对象设置ItemCellTableViewCell对象
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"$%d",item.valueInDollars];
    
//    cell.textLabel.text = [item description];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc]init];
    
    NSArray *items = [[ItemStore sharedStore]allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    detailViewController.item = selectedItem;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果UITableView对象请求确认的是删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[ItemStore sharedStore]allItems];
        BNRItem *item = items[indexPath.row];
        [[ItemStore sharedStore]removeItem:item];
    //还要删除表格视图中的相应表格行（带动画效果）
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[ItemStore sharedStore]moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

//更改TableViewCell中删除的Title
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"Remove";
//}
//
//规定最后一行不可移动
//-(BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSArray *items = [[ItemStore sharedStore]allItems];
//    if (indexPath.row == items.count - 1) {
//        return NO;
//    }
//    return YES;
//}

@end
