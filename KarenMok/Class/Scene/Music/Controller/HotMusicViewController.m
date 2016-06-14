//
//  HotMusicViewController.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/23.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "HotMusicViewController.h"
#import "Music.h"
#import "AVAplayer.h"
#import "PlayViewController.h"
#import "Reachability.h"
#import "AlbumListCell.h"

@interface HotMusicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation HotMusicViewController

// ???为什么是这个初始化方法, 其他的是干什么的
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    self.dataArr = [NSMutableArray array];
    [self handleData];
        
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)handleData
{
    NSString *str = HotMusicAPI;
    
    __block HotMusicViewController *own = self;
    
    
    [NetHandler getDataWithUrl:str completion:^(id data) {
        
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
       
        NSDictionary *dataDic = [resultDic objectForKey:@"data"];
        NSArray *songsArr = [dataDic objectForKey:@"songs"];
        
        for (NSDictionary *dic in songsArr) {
            Music *music = [[Music alloc] init];
            [music setValuesForKeysWithDictionary:dic];
            [own.dataArr addObject:music];
            [own.tableView reloadData];
            [self.hud hide:YES];
        }

    }];
}


#pragma mark ---- viewDidLoad ----

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"音乐";
    
    // 因为把导航栏设置为透明了, 为了让导航栏也显示黑色, 就把整个view背景设置黑色了, (好像整麻烦了...将错就错了)
    // 上面的写错了, 此处的导航栏的颜色根背景没关系
//    self.view.backgroundColor = [UIColor blackColor];
    
    

    // tableView
//    ??? 为什么-64才能显示全呢?
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 因为热门歌曲列表和专辑歌曲列表是一样的结构, 所以用了同一个自定义cell
    
    static NSString *str = @"hotCell";
    AlbumListCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[AlbumListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    
    // 改变点击cell时cell的颜色
    UIView *aView = [[UIView alloc] initWithFrame:cell.contentView.frame];
    aView.backgroundColor = [UIColor colorWithRed:155/255.0 green:34/255.0 blue:63/255.0 alpha:1.0];
    cell.selectedBackgroundView = aView;

    Music *music = [self.dataArr objectAtIndex:indexPath.row];
    cell.label.text = music.song_name;
    cell.label.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor blackColor];
    [cell.myImageView setImageWithURL:[NSURL URLWithString:music.logo]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayViewController *playVC = [[PlayViewController alloc] init];
    Music *music = [self.dataArr objectAtIndex:indexPath.row];
    playVC.music = music;
    
    playVC.dataArr = self.dataArr;
//    playVC.numberNext = indexPath.row + 1;
    playVC.numberPre = indexPath.row;
    
    [self.navigationController pushViewController:playVC animated:YES];
    
}

@end
