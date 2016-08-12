//
//  BarChangeController.m
//  PersonView
//
//  Created by 付宗建 on 16/8/12.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "BarChangeController.h"
#import "UINavigationBar+Custom.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface BarChangeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * BarChangeTableView;
@property (nonatomic,strong) UIView * HeaderView;
@end

@implementation BarChangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.BarChangeTableView];
    self.BarChangeTableView.tableHeaderView = self.HeaderView;
    // Do any additional setup after loading the view.
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    [self.navigationController.navigationBar custom_reset];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
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
    CGFloat offset_y = scrollView.contentOffset.y;
    if (offset_y > 0) {
        if (offset_y >= 44) {
            [self setCustomNavigationBarTransformProgress:1];
        }else{
            [self setCustomNavigationBarTransformProgress:(offset_y / 44)];
        }
    }else{
        [self setCustomNavigationBarTransformProgress:0];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    }
}
- (void)setCustomNavigationBarTransformProgress:(CGFloat)progress{
    [self.navigationController.navigationBar custom_setTranslationY:- 44 * progress];
    [self.navigationController.navigationBar custom_setAlpha:1 - progress];
}
- (UITableView *)BarChangeTableView{
    if (_BarChangeTableView == nil) {
        _BarChangeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _BarChangeTableView.delegate = self;
        _BarChangeTableView.dataSource = self;
    }
    return _BarChangeTableView;
}
- (UIView *)HeaderView{
    if (_HeaderView == nil) {
        _HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:_HeaderView.bounds];
        imageView.image = [UIImage imageNamed:@"bg.jpg"];
        [_HeaderView addSubview:imageView];
    }
    return _HeaderView;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
