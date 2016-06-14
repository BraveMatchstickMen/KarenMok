//
//  AlbumListViewController.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/27.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "AlbumListViewController.h"
#import "PlayViewController.h"
#import "Album.h"
#import "Music.h"
#import "AlbumListCell.h"

@interface AlbumListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *albumListArr;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AlbumListViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        [self handleAlbumListData];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"kong.jpg"] forBarMetrics:UIBarMetricsDefault];//一张透明的有大小的图片
//    [self.navigationController.navigationBar setTranslucent:YES];
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];

    // 在视图将要出现调用, 会导致每次进入页面都重新请求数据, 并且上一次的依然存在, 解决方法: 将数据数组初始化
    
    self.albumListArr = [NSMutableArray array];
    
    [self handleAlbumListData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    // self.navigationController.navigationBar.translucent = NO;这个属性是让导航栏不算在坐标计算内, 但是会导致最下方页面显示不全, 修正方法是让它的高度-64
    
    // 所有的导航栏属性都跟着推出它的页面走, 也就是说你设置了主页的导航栏属性后, 由主页push出的所有页面的导航栏都是跟主页的一样
    
    // 为什么navigation会是黑色的 ???
    
    
//    NSLog(@"balablabal  %@", self.albumListArr);
//    self.albumListArr = [NSMutableArray array];
//    self.view.backgroundColor = [UIColor blackColor];
    
    
    self.title = self.album_name;
    
//    ??? 为什么在init方法调用, 请求不到数据
//    [self handleAlbumListData];
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.albumListArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"albumListCell";
    AlbumListCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[AlbumListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    // 改变点击cell时cell的颜色
    UIView *aView = [[UIView alloc] initWithFrame:cell.contentView.frame];
    aView.backgroundColor = [UIColor colorWithRed:155/255.0 green:34/255.0 blue:63/255.0 alpha:1.0];
    cell.selectedBackgroundView = aView;

    
    Music *music = [self.albumListArr objectAtIndex:indexPath.row];
    [cell.myImageView setImageWithURL:[NSURL URLWithString:music.logo]];
    
    cell.label.text = music.song_name;
    cell.label.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayViewController *playVC = [[PlayViewController alloc] init];
    playVC.dataArr = self.albumListArr;
    playVC.numberPre = indexPath.row;
    [self.navigationController pushViewController:playVC animated:YES];
}




- (void)handleAlbumListData
{
    NSString *str = self.albumListUrl;
    
    [NetHandler getDataWithUrl:str completion:^(id data) {
        
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dic = [resultDic objectForKey:@"data"];
        NSArray *arr = [dic objectForKey:@"songs"];

        for (NSDictionary *albumDic in arr) {
            Music *music = [[Music alloc] init];
            [music setValuesForKeysWithDictionary:albumDic];
            [self.albumListArr addObject:music];
            
            [self.tableView reloadData];
            
            [self.hud hide:YES];
         }
    }];
}

@end
