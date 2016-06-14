//
//  MVPlayViewController.m
//  KarenMok
//
//  Created by BraveMatch on 15/2/14.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "MVPlayViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AVAplayer.h"

@interface MVPlayViewController ()<MBProgressHUDDelegate>

// 视频
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation MVPlayViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AVAplayer *avplayer = [AVAplayer defaultAvPlayer];
    [avplayer pause];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.moviePlayer pause];
}


//设置loading
- (void)p_setupProgressHud
{
    // The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
    self.HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    self.HUD.delegate = self;
    
    self.HUD.labelText = @"努力的加载中...";
    
    // Show the HUD while the provided method executes in a new thread
    [self.HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}


- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(30);
}




#pragma mark - 控制器视图方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupProgressHud];
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"mok.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonAction)];
    
    //播放
    [self.moviePlayer play];
    
    //添加通知
    [self addNotification];
    
}

-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)barButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}



/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    NSString *urlStr = self.urlString;
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayer
{
    
//    ???  _moviePlayer 写成  self.moviePlayer 会造成循环引用?
    
    if (!_moviePlayer) {
        NSURL *url=[self getNetworkUrl];
        self.moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        self.moviePlayer.view.frame=self.view.bounds;
        self.moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            
//            self.HUD.hidden = YES;
            [self.HUD removeFromSuperview];
            
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}


@end

