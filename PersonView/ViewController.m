//
//  ViewController.m
//  PersonView
//
//  Created by 付宗建 on 16/8/12.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "ViewController.h"
#import "DrawBigController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *PersonTableView;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) NSArray * controllerArray;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.PersonTableView.tableFooterView = [UIView new];
    
    self.dataArray = [NSArray arrayWithObjects:@"下来放大效果",@"导航栏变化",@"导航栏背景颜色变化", nil];
    self.controllerArray = [NSArray arrayWithObjects:@"DrawBigController",@"BarChangeController",@"BarColorChangeController", nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController * nextController = [[NSClassFromString([self.controllerArray objectAtIndex:indexPath.row]) alloc] init] ;
    nextController.title = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:nextController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
