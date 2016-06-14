//
//  AboutViewController.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/19.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutDetailViewController.h"

@interface AboutViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *detailArr;

@end

@implementation AboutViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataArr = [NSMutableArray arrayWithObjects:@"个人资料", @"关于莫文蔚", @"BIO", @"电影演出", @"音乐专辑", @"演出及个人演唱会", @"歌舞剧及舞台剧演出", @"商品代言", @"个人品牌及产品", @"演艺成就及其他奖项", @"慈善活动", @"国际电影节", nil];
        self.detailArr = [NSMutableArray arrayWithObjects:[NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"mok0" ofType:@"txt"] encoding: NSUTF8StringEncoding error: NULL], [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"mok1" ofType:@"txt"] encoding: NSUTF8StringEncoding error: NULL], [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"mok2" ofType:@"txt"] encoding: NSUTF8StringEncoding error: NULL], [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"mok3" ofType:@"txt"] encoding: NSUTF8StringEncoding error: NULL], [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"mok4" ofType:@"txt"] encoding: NSUTF8StringEncoding error: NULL], [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"mok5" ofType:@"txt"] encoding: NSUTF8StringEncoding error: NULL],  [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"mok6" ofType:@"txt"] encoding: NSUTF8StringEncoding error: NULL],  [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"mok7" ofType:@"txt"] encoding: NSUTF8StringEncoding error: NULL],  [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"mok8" ofType:@"txt"] encoding: NSUTF8StringEncoding error: NULL],  [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"mok9" ofType:@"txt"] encoding: NSUTF8StringEncoding error: NULL],  [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"mok10" ofType:@"txt"] encoding: NSUTF8StringEncoding error: NULL],  [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"mok11" ofType:@"txt"] encoding: NSUTF8StringEncoding error: NULL], nil];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.hud hide:YES];
    self.title = @"关于Mok";
    
//    FIXME 把style换成UITableViewStylePlain, 当cell到headerView上时则无法点击
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = [UIColor colorWithRed:155/255.0 green:34/255.0 blue:63/255.0 alpha:1.0];
    
    // 给tableView设置背景
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300/667.0*SCREEN_HEIGHT)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:@"img-about.jpg"];
    imageView.frame = CGRectMake(20, 50, imageView.image.size.width, imageView.image.size.height);
    [backView addSubview:imageView];
    [self.tableView setBackgroundView:backView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 290/667.0*SCREEN_HEIGHT)];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.userInteractionEnabled = YES;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 290/667.0*SCREEN_HEIGHT;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120/667.0*SCREEN_HEIGHT;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"aboutCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    // 改变点击cell时cell的颜色
    UIView *aView = [[UIView alloc] initWithFrame:cell.contentView.frame];
    aView.backgroundColor = [UIColor colorWithRed:155/255.0 green:34/255.0 blue:63/255.0 alpha:1.0];
    cell.selectedBackgroundView = aView;
    
    // 给cell上添加向右的箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 判断, 给每个cell加上图片
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"Branding.png"];
    }
    
    if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"Charities.png"];
    }
    
    if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"milest.png"];
    }
    
    if (indexPath.row == 3) {
        cell.imageView.image = [UIImage imageNamed:@"movie.png"];
    }
    
    if (indexPath.row == 4) {
        cell.imageView.image = [UIImage imageNamed:@"music.png"];
    }
    
    if (indexPath.row == 5) {
        cell.imageView.image = [UIImage imageNamed:@"Concerts-.png"];
    }
    
    if (indexPath.row == 6) {
        cell.imageView.image = [UIImage imageNamed:@"Performance-.png"];
    }
    
    if (indexPath.row == 7) {
        cell.imageView.image = [UIImage imageNamed:@"Endorsement.png"];
    }
    
    if (indexPath.row == 8) {
        cell.imageView.image = [UIImage imageNamed:@"Branding.png"];
    }
    
    if (indexPath.row == 9) {
        cell.imageView.image = [UIImage imageNamed:@"award1.png"];
    }
    
    if (indexPath.row == 10) {
        cell.imageView.image = [UIImage imageNamed:@"Charities.png"];
    }
    
    if (indexPath.row == 11) {
        cell.imageView.image = [UIImage imageNamed:@"Film.png"];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AboutDetailViewController *aboutDetailVC = [[AboutDetailViewController alloc] init];
    
    aboutDetailVC.str = [self.detailArr objectAtIndex:indexPath.row];
    
    aboutDetailVC.detailTitle = [self.dataArr objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:aboutDetailVC animated:YES];
    
}




@end
