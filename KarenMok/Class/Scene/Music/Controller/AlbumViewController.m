//
//  AlbumViewController.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/27.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumCell.h"
#import "Album.h"
#import "AlbumListViewController.h"
#import "PhotoViewController.h"
#import "AboutViewController.h"
#import "HotMusicViewController.h"
#import <MessageUI/MessageUI.h>
#import "Reachability.h"
#import "MVViewController.h"
#import "AlbumView.h"
#import "ReactViewController.h"

@interface AlbumViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, MFMailComposeViewControllerDelegate, MBProgressHUDDelegate>
@property (nonatomic, strong) AlbumView *albumView;

@property (nonatomic, strong) NSMutableArray *albumArr;
@property (nonatomic, strong) NSArray *locDataArr;
@property (nonatomic, strong) UICollectionView *collectionView;


@property (strong, nonatomic) UITextField *toTecipients;//收件人
@property (strong, nonatomic) UITextField *ccRecipients;//抄送人
@property (strong, nonatomic) UITextField *bccRecipients;//密送人
@property (strong, nonatomic) UITextField *subject; //主题
@property (strong, nonatomic) UITextField *body;//正文
@property (strong, nonatomic) UITextField *attachments;//附件

@property (strong, nonatomic) MBProgressHUD *HUD;


@end

@implementation AlbumViewController

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
    [self setNaviagtionBarClear];
    
    self.albumArr = [NSMutableArray array];
    self.locDataArr = [NSArray array];
    
        [self handleAlbumData];
        [self handleLocationData];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self barButtonActionAgain];
}


- (void)setNaviagtionBarClear
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"kong.jpg"] forBarMetrics:UIBarMetricsDefault];//一张透明的有大小的图片
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
}


- (void)setMBProgressHUDView
{
    // The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
    self.HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    self.HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [self.HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(30);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setMBProgressHUDView];

    self.title = @"专辑";
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"mok.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonAction)];
    
    
    self.albumView = [[AlbumView alloc] initWithFrame:self.view.bounds];
    self.view = self.albumView;
    
    
    // 相册
    [self.albumView.about addTarget:self action:@selector(photoAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 金典热曲
    [self.albumView.photo addTarget:self action:@selector(hotAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    // mv
    [self.albumView.mv addTarget:self action:@selector(mvAction) forControlEvents:UIControlEventTouchUpInside];
    
    // about
    [self.albumView.hot addTarget:self action:@selector(aboutAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 联系我们
    [self.albumView.feedBack addTarget:self action:@selector(sendEmailClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.albumView.favorite addTarget:self action:@selector(favoriteClick) forControlEvents:UIControlEventTouchUpInside];

    
    // 创建collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 每个item间距
    flowLayout.minimumInteritemSpacing = 20/375.0*SCREEN_WIDTH;
    
    // 最小行间距
    flowLayout.minimumLineSpacing = 30/667.0*SCREEN_HEIGHT;
    
    flowLayout.itemSize = CGSizeMake(110/375.0*SCREEN_WIDTH, 110/375.0*SCREEN_WIDTH + 20);
    
//    flowLayout.headerReferenceSize = CGSizeMake(375, 40);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2, 0, self.view.bounds.size.width, self.albumView.bigScrollView.frame.size.height - 64) collectionViewLayout:flowLayout];
//    collectionView.backgroundColor = [UIColor brownColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.albumView.bigScrollView addSubview:self.collectionView];
    
    
    // collectionView 必须注册一个cell类
    [self.collectionView registerClass:[AlbumCell class] forCellWithReuseIdentifier:@"albumCell"];
    
    // collectionView 给section注册一个view显示内容
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerReuse"];
}


- (void)barButtonAction
{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.albumView.bigScrollView.contentOffset = CGPointMake(0, -64);
    }];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"mok.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonActionAgain)];
    
}

- (void)barButtonActionAgain
{
    [UIView animateWithDuration:0.8 animations:^{
        self.albumView.bigScrollView.contentOffset = CGPointMake(self.view.frame.size.width/2, -64);
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"mok.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonAction)];
    
}

- (void)mvAction
{
    MVViewController *mvVC = [[MVViewController alloc] init];
    [self.navigationController pushViewController:mvVC animated:YES];
}


- (void)photoAction
{
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    [self.navigationController pushViewController:photoVC animated:YES];
}


- (void)hotAction
{
    HotMusicViewController *hotVC = [[HotMusicViewController alloc] init];
    [self.navigationController pushViewController:hotVC animated:YES];
}


- (void)aboutAction
{
    AboutViewController *aboutVC = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:aboutVC animated:YES];
}

- (void)favoriteClick
{
    ReactViewController *collectVC = [[ReactViewController alloc] init];
    [self.navigationController pushViewController:collectVC animated:YES];
}


#pragma mark ----- MessageUI.h ----
- (void)sendEmailClick:(UIButton *)sender {
    //判断当前是否能够发送邮件
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailController=[[MFMailComposeViewController alloc]init];
        //设置代理，注意这里不是delegate，而是mailComposeDelegate
        mailController.mailComposeDelegate=self;
        //设置收件人
        
        [mailController setToRecipients:[NSArray arrayWithObjects:@"1979840601@qq.com", nil]];
        //设置抄送人
        if (self.ccRecipients.text.length>0) {
            [mailController setCcRecipients:[self.ccRecipients.text componentsSeparatedByString:@","]];
        }
        //设置密送人
        if (self.bccRecipients.text.length>0) {
            [mailController setBccRecipients:[self.bccRecipients.text componentsSeparatedByString:@","]];
        }
        //设置主题
        [mailController setSubject:self.subject.text];
        //设置内容
        [mailController setMessageBody:self.body.text isHTML:YES];
        //添加附件
        if (self.attachments.text.length>0) {
            NSArray *attachments=[self.attachments.text componentsSeparatedByString:@","] ;
            [attachments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *file=[[NSBundle mainBundle] pathForResource:obj ofType:nil];
                NSData *data=[NSData dataWithContentsOfFile:file];
                [mailController addAttachmentData:data mimeType:@"image/jpeg" fileName:obj];//第二个参数是mimeType类型，jpg图片对应image/jpeg
            }];
        }
        [self presentViewController:mailController animated:YES completion:nil];
        
    }
}
#pragma mark - MFMailComposeViewController代理方法
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"发送成功.");
            break;
        //如果存储为草稿（点取消会提示是否存储为草稿，存储后可以到系统邮件应用的对应草稿箱找到）
        case MFMailComposeResultSaved:
            NSLog(@"邮件已保存.");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"取消发送.");
            break;
            
        default:
            NSLog(@"发送失败.");
            break;
    }
    if (error) {
        NSLog(@"发送邮件过程中发生错误，错误信息：%@",error.localizedDescription);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


// item 的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.albumArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"albumCell" forIndexPath:indexPath];
    Album *album = [self.albumArr objectAtIndex:indexPath.row];
    
    // 系统提供的cell没有任何自带的控件, 完全需要我们自定义
//    cell.backgroundColor = [UIColor greenColor];
    cell.labelTitle.text = album.album_name;
    cell.labelTitle.font = [UIFont systemFontOfSize:13];
    cell.labelTitle.textColor = [UIColor whiteColor];
    cell.labelTitle.textAlignment = NSTextAlignmentCenter;
    [cell.imageView setImageWithURL:[NSURL URLWithString:album.logo]];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumListViewController *albumListVC = [[AlbumListViewController alloc] init];
    NSString *albumListUrl = [self.locDataArr objectAtIndex:indexPath.row];
    albumListVC.albumListUrl = albumListUrl;
    albumListVC.album_name = [[self.albumArr objectAtIndex:indexPath.row] album_name];
//    NSLog(@"======== %@", albumListVC.albumListUrl);
    [self.navigationController pushViewController:albumListVC animated:YES];
}


- (void)handleLocationData
{
    
    NSString *aboutPath = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"albumList" ofType:@".txt"] encoding:NSUTF8StringEncoding error:nil];
    
    
//    NSString *pathAbout = @"/Users/bravematch/Desktop/KarenMok/KarenMok/LocationData/AlbumList/albumList.txt";
//    NSString *path = [[NSBundle mainBundle] pathForResource:pathAbout ofType:@".txt"];
//    NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // 上面的写法是不会请求到数据的, 因为pathForResource后面跟着的是文件名, 而不是文件路径!!!
    
    NSArray *array = [aboutPath componentsSeparatedByString:@"\n"];
    self.locDataArr = [NSArray arrayWithArray:array];
//    NSLog(@"%@", self.locDataArr);
}



- (void)handleAlbumData
{
    
    NSString *strr = [NSString stringWithFormat:AlbumAPI];
    
    __block AlbumViewController *own = self;
    
    [NetHandler getDataWithUrl:strr completion:^(id data) {
        
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dic = [resultDic objectForKey:@"data"];
        NSArray *arr = [dic objectForKey:@"albums"];
        
        for (NSDictionary *albumDic in arr) {
            Album *album = [[Album alloc] init];
            [album setValuesForKeysWithDictionary:albumDic];
            [own.albumArr addObject:album];
            [own.collectionView reloadData];
        }
        
        [self.HUD hide:YES];

    }];

}

@end
