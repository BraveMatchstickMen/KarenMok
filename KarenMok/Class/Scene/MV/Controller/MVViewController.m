//
//  MVViewController.m
//  KarenMok
//
//  Created by BraveMatch on 15/2/14.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "MVViewController.h"
#import "MVPlayViewController.h"
#import "MV.h"
#import "AlbumListCell.h"

@interface MVViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation MVViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataArr = [NSMutableArray array];
        [self handleMVData];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.dataArr = [NSMutableArray array];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)handleMVData
{
    // json解析
    
    
    // 1. 获取文件Data
    NSString *path = [[NSBundle mainBundle] pathForResource:@"mv1" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    // 2. 解析
    
    // 参数1: 文件数据
    // 参数2: 解析的选项
    // 参数3: 错误信息
    
    NSError *error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    //    NSLog(@"error: %@", error);
    
    NSArray *arr = [result objectForKey:@"videos"];
    
    for (NSDictionary *dic in arr) {
        MV *mv = [[MV alloc] init];
        [mv setValuesForKeysWithDictionary:dic];
        [self.dataArr addObject:mv];
    }
    
//    NSLog(@"%@", self.dataArr);
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"MOK MV";
    if (self.dataArr != nil) {
        [self.hud hide:YES];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"mv";
    AlbumListCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[AlbumListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    // 改变点击cell时cell的颜色
    UIView *aView = [[UIView alloc] initWithFrame:cell.contentView.frame];
    aView.backgroundColor = [UIColor colorWithRed:155/255.0 green:34/255.0 blue:63/255.0 alpha:1.0];
    cell.selectedBackgroundView = aView;
    
    cell.backgroundColor = [UIColor blackColor];
    
    MV *mv = [self.dataArr objectAtIndex:indexPath.row];
    [cell.myImageView setImageWithURL:[NSURL URLWithString:mv.albumImg]];
    cell.label.text = mv.title;
    cell.label.textColor = [UIColor whiteColor];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MVPlayViewController *mvPlayVC = [[MVPlayViewController alloc] init];
    MV *mv = [self.dataArr objectAtIndex:indexPath.row];
    mvPlayVC.urlString = mv.uhdUrl;
    
    [self.navigationController pushViewController:mvPlayVC animated:YES];
}



@end
