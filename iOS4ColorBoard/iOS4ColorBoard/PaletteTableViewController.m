//
//  PaletteTableViewController.m
//  iOS4ColorBoard
//
//  Created by 代隽杰 on 16/3/14.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "PaletteTableViewController.h"
#import "ViewController.h"
#import "ColorDescription.h"

@interface PaletteTableViewController ()

@property (nonatomic) NSMutableArray *colors;

@end

@implementation PaletteTableViewController

#pragma segue
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewColor"]) {
        ColorDescription *color    = [[ColorDescription alloc]init];
        [self.colors addObject:color];

        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        ViewController *mvc        = (ViewController *)[nc topViewController];
        mvc.colorDescription       = color;

    }else if([segue.identifier isEqualToString:@"ExistingColor"]){
        NSIndexPath *ip            = [self.tableView indexPathForCell:sender];
        ColorDescription *color    = self.colors[ip.row];
        ViewController *cvc = (ViewController *)segue.destinationViewController;
        cvc.colorDescription = color;
        cvc.existongColor = YES;
    }
}


-(NSMutableArray *) colors
{
    if (!_colors) {
        _colors              = [NSMutableArray array];
        ColorDescription *cd = [[ColorDescription alloc]init];
        [_colors addObject: cd];
    }
    return  _colors;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [self.colors count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    ColorDescription *color = self.colors[indexPath.row];
    cell.textLabel.text     = color.name;

    return cell;
}

@end
