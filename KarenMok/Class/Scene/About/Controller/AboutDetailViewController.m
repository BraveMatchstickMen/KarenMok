//
//  AboutDetailViewController.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/19.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "AboutDetailViewController.h"


@interface AboutDetailViewController ()



@end

@implementation AboutDetailViewController


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

    self.view.backgroundColor = [UIColor blackColor];
    
    self.title = self.detailTitle;
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.translucent = NO;
    
    // create a UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 607/667.0*SCREEN_HEIGHT - 64)];
    scrollView.contentSize = CGSizeZero;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    
    [self.view addSubview:scrollView];
    
    // create a UILabel which display detail content
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(20/375.0*SCREEN_WIDTH, 40, 335/375.0*SCREEN_WIDTH, 600/667.0*SCREEN_HEIGHT)];
    
//  FIXME 如何让底部的返回按钮不覆盖显示内容
    self.label.numberOfLines = 0;
    

    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 20;
    paraStyle.firstLineHeadIndent = 32;
    
    NSDictionary *dic = @{NSParagraphStyleAttributeName:paraStyle, NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    self.label.attributedText = [[NSAttributedString alloc] initWithString:self.str attributes:dic];
    
    self.label.textColor = [UIColor colorWithRed:135/255.0 green:132/255.0 blue:129/255.0 alpha:1.0];
    
    [self.label sizeToFit];
    
    scrollView.contentSize = CGSizeMake(0, self.label.frame.size.height + 80);

    [scrollView addSubview:self.label];
    
    // create a UIButton which back previous page
    UIButton *btBack = [UIButton buttonWithType:UIButtonTypeSystem];
    btBack.frame = CGRectMake(20, 627/667.0*SCREEN_HEIGHT - 64, 40/667.0*SCREEN_HEIGHT, 40/667.0*SCREEN_HEIGHT);
//    btBack.backgroundColor = [UIColor redColor];
    [btBack setImage:[[UIImage imageNamed:@"mok.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btBack addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btBack];
    
    
}


- (void)buttonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
