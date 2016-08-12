//
//  BarColorChangeController.m
//  PersonView
//
//  Created by 付宗建 on 16/8/12.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "BarColorChangeController.h"
#import "UINavigationBar+Custom.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define BAR_CHANGE_VALUE 50
#define HeaderView_Height 150
@interface BarColorChangeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * BarColorChangeTableView;
@property (nonatomic,strong) UIView * HeaderView;
@property (nonatomic,strong) UIImageView * PictureImageView;

@end
@implementation BarColorChangeController
- (void)viewDidLoad{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.BarColorChangeTableView];
    self.BarColorChangeTableView.tableHeaderView = self.HeaderView;
    
    [self.navigationController.navigationBar custom_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:self.BarColorChangeTableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar custom_reset];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"下拉看效果";
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offset_y = scrollView.contentOffset.y;
    if (offset_y > BAR_CHANGE_VALUE) {
        CGFloat alpha = MIN(1, 1 - (BAR_CHANGE_VALUE + 64 - offset_y) / 64);
        [self.navigationController.navigationBar custom_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    }else{
        [self.navigationController.navigationBar custom_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    
    if (offset_y < 0) {
        //拉伸后图片的高度
        CGFloat totalOffset = HeaderView_Height - offset_y;
        //图片放大比例
        CGFloat scale = totalOffset / HeaderView_Height;
        CGFloat width = kScreenWidth;
        //拉伸后图片位置
        self.PictureImageView.frame = CGRectMake(-(width * scale - width)/2, offset_y, width * scale, totalOffset);
    }
}

- (UITableView *)BarColorChangeTableView{
    if (_BarColorChangeTableView == nil) {
        _BarColorChangeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 0) style:UITableViewStylePlain];
        _BarColorChangeTableView.delegate = self;
        _BarColorChangeTableView.dataSource = self;
    }
    return _BarColorChangeTableView;
}
- (UIView *)HeaderView{
    if (_HeaderView == nil) {
        _HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeaderView_Height)];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:_HeaderView.bounds];
        imageView.image = [UIImage imageNamed:@"bg.jpg"];
        [_HeaderView addSubview:imageView];
        _PictureImageView = imageView;
    }
    return _HeaderView;
}

@end
