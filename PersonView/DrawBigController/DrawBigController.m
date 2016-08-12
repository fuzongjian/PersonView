//
//  DrawBigController.m
//  PersonView
//
//  Created by 付宗建 on 16/8/12.
//  Copyright © 2016年 youran. All rights reserved.
//

#import "DrawBigController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ImageHeight 200
@interface DrawBigController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * DrawBigTableView;
@property (nonatomic,strong) UIView * HeaderView;
@property (nonatomic,strong) UIImageView * PictureImageView;
@end

@implementation DrawBigController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.DrawBigTableView];
    self.DrawBigTableView.tableHeaderView = self.HeaderView;
    [self.HeaderView addSubview:self.PictureImageView];
    
    // Do any additional setup after loading the view.
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
    // 开始偏移量为0，向下为负 上为正
    //获取到tableView偏移量
    CGFloat offset_y = scrollView.contentOffset.y;
    //下拉 纵向偏移量变小 变成负
    if (offset_y < 0) {
        //拉伸后图片的高度
        CGFloat totalOffset = ImageHeight - offset_y;
        //图片放大比例
        CGFloat scale = totalOffset / ImageHeight;
        CGFloat width = kScreenWidth;
        //拉伸后图片位置
        self.PictureImageView.frame = CGRectMake(-(width * scale - width)/2, offset_y, width * scale, totalOffset);
            
        
    }
    
//    NSLog(@"%.2f",offset_y);
}
- (UITableView *)DrawBigTableView{
    if (_DrawBigTableView == nil) {
        _DrawBigTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _DrawBigTableView.delegate = self;
        _DrawBigTableView.dataSource = self;
    }
    return _DrawBigTableView;
}
- (UIView *)HeaderView{
    if (_HeaderView == nil) {
        _HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ImageHeight)];
    }
    return _HeaderView;
}
- (UIImageView *)PictureImageView{
    if (_PictureImageView == nil) {
        _PictureImageView = [[UIImageView alloc] initWithFrame:self.HeaderView.bounds];
        _PictureImageView.image = [UIImage imageNamed:@"picture"];
        _PictureImageView.contentMode = UIViewContentModeScaleAspectFill;
        _PictureImageView.clipsToBounds = YES;
    }
    return _PictureImageView;
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
