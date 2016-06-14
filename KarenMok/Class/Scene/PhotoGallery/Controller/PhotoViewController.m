//
//  PhotoViewController.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/21.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCell.h"
#import "UIImageView+WebCache.h"
#import "GalleryViewController.h"

@interface PhotoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) NSArray *arrPhoto;
@property (nonatomic, strong) NSArray *arrPhoto2;
@property (nonatomic, strong) NSArray *arrPhoto3;
@property (nonatomic, strong) NSArray *arrPhoto4;
@property (nonatomic, strong) NSArray *arrPhoto5;

@end

@implementation PhotoViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}



- (void)handleLocationData
{
    NSString *str = LOADTXT(@"bottomPhoto");
    NSArray *array = [str componentsSeparatedByString:@"\n"];
    self.arr = [NSArray arrayWithArray:array];
    
    NSString *strPhoto = LOADTXT(@"photo1");
    NSArray *arr = [strPhoto componentsSeparatedByString:@"\n"];
    self.arrPhoto = [NSArray arrayWithArray:arr];

    NSString *strPhoto2 = LOADTXT(@"photo2");
    NSArray *arr2 = [strPhoto2 componentsSeparatedByString:@"\n"];
    self.arrPhoto2 = [NSArray arrayWithArray:arr2];
    
    NSString *strPhoto3 = LOADTXT(@"photo3");
    NSArray *arr3 = [strPhoto3 componentsSeparatedByString:@"\n"];
    self.arrPhoto3 = [NSArray arrayWithArray:arr3];

    NSString *strPhoto4 = LOADTXT(@"photo4");
    NSArray *arr4 = [strPhoto4 componentsSeparatedByString:@"\n"];
    self.arrPhoto4 = [NSArray arrayWithArray:arr4];
    
    NSString *strPhoto5 = LOADTXT(@"photo5");
    NSArray *arr5 = [strPhoto5 componentsSeparatedByString:@"\n"];
    self.arrPhoto5 = [NSArray arrayWithArray:arr5];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.hud hide:YES];
    self.title = @"相册";
    
    self.array = [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", nil];
    [self handleLocationData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
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
    return 60;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400/667.0*SCREEN_HEIGHT;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"photoCell";
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    
    // 改变点击cell时cell的颜色
    UIView *aView = [[UIView alloc] initWithFrame:cell.contentView.frame];
    aView.backgroundColor = [UIColor colorWithRed:155/255.0 green:34/255.0 blue:63/255.0 alpha:1.0];
    cell.selectedBackgroundView = aView;
    
    cell.backgroundColor = [UIColor blackColor];
    cell.imageViewBottom.image = [UIImage imageNamed:@"profile_album.png"];
    
    NSString *number = [self.array objectAtIndex:indexPath.section];

    NSString *strr = [self.arr objectAtIndex:[number intValue]];
    NSURL *pic_url = [NSURL URLWithString:strr];
    
    [cell.imageViewHome setImageWithURL:pic_url placeholderImage:[UIImage imageNamed:@"like.jpg"]];
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GalleryViewController *gallerVC = [[GalleryViewController alloc] init];
    if (indexPath.section == 0) {
        
        gallerVC.imageArr = self.arrPhoto;
    }
    
    if (indexPath.section == 1) {
        gallerVC.imageArr = self.arrPhoto2;
    }
    
    if (indexPath.section == 2) {
        gallerVC.imageArr = self.arrPhoto3;
    }
    
    if (indexPath.section == 3) {
        gallerVC.imageArr = self.arrPhoto4;
    }
    
    if (indexPath.section == 4) {
        gallerVC.imageArr = self.arrPhoto5;
    }
    
    [self presentViewController:gallerVC animated:YES completion:^{
        
    }];
}

@end
