//
//  BasedTableViewController.m
//  KarenMok
//
//  Created by BraveMatch on 15/3/4.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "BasedTableViewController.h"

@interface BasedTableViewController ()


//设置loading
- (void)p_setupProgressHud;

@end

@implementation BasedTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"mok.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonAction)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor blackColor];
    
    // 去除tableView多余的cell
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //不显示tableView的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置显示loading
    [self p_setupProgressHud];
}

- (void)barButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}



//设置loading
- (void)p_setupProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}

//发起网络请求
- (void)sendRequest
{
    //子类重写实现具体方法
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
