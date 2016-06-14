//
//  PlayViewController.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/23.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "PlayViewController.h"
#import "AVAplayer.h"
#import "Music.h"
#import "AVAplayerView.h"

@interface PlayViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) AVAplayerView *avplayerView;

@property (nonatomic, strong) Music *musicValue;

@property (nonatomic, strong) AVAplayer *avplayer;

@property (nonatomic, strong) UITableView *lrcTableView;

@property (nonatomic, strong) NSMutableDictionary *LRCDictionary;
@property (nonatomic, strong) NSMutableArray *timeArray;
@property (nonatomic, strong) NSMutableArray *lrcArray;

@property (nonatomic, assign) NSUInteger lrcLineNumber;
@property (nonatomic, assign) NSUInteger musicArrayNumber;

@end

@implementation PlayViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        self.dataArr = [NSArray array];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    
    //一张透明的有大小的图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"kong.jpg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self removeObserverFromPlayerItem:self.avplayer.currentItem];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.musicValue = self.music;
    
    self.title = [self.dataArr[self.numberPre] song_name];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonAction)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.avplayer.currentItem];
    
    
    [self updatePlayerSetting];
    
    self.avplayerView = [[AVAplayerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.avplayerView];
    
    // 播放页面背景设置
    [self.avplayerView.imageView setImageWithURL:[NSURL URLWithString:[self judgePicture]] placeholderImage:[UIImage imageNamed:@"like.jpg"]];
    
    // logo设置
    [self.avplayerView.imageViewLogo setImageWithURL:[NSURL URLWithString:[self judgePicture]] placeholderImage:[UIImage imageNamed:@"like.jpg"]];

// TODO 监听播放按钮状态
    
    // 开始播放按钮
    [self.avplayerView.buttonPlay addTarget:self action:@selector(buttonPauseAction) forControlEvents:UIControlEventTouchUpInside];

    // 上一首按钮
    [self.avplayerView.buttonPre addTarget:self action:@selector(buttonPreAction) forControlEvents:UIControlEventTouchUpInside];

    // 下一首按钮
    [self.avplayerView.buttonNext addTarget:self action:@selector(buttonNextAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 进度条
    [self.avplayerView.sliderProgress addTarget:self action:@selector(changeTimerValue:) forControlEvents:UIControlEventValueChanged];
    
    // 当前时间
    [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(changeTimer) userInfo:nil repeats:YES];
    
    // 总共的时间
    self.avplayerView.labelTotalTime.text = [self convertTime:[[self.dataArr[self.numberPre] play_seconds] floatValue]];
    
    // lrc
    self.lrcTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 400/667.0*SCREEN_HEIGHT, 335/375.0*SCREEN_WIDTH, 105/667.0*SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.lrcTableView.delegate = self;
    self.lrcTableView.dataSource = self;
    self.lrcTableView.backgroundColor = [UIColor clearColor];
    self.lrcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.lrcTableView];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(changeTimer) userInfo:nil repeats:YES];
}


/**
 *  给AVPlayerItem添加监控
 *
 *  @param playerItem AVPlayerItem对象
 */
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}


-(void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}



/*
 status有三种状态:
 AVPlayerStatusUnknown,
 AVPlayerStatusReadyToPlay,
 AVPlayerStatusFailed
 当status等于AVPlayerStatusReadyToPlay时代表视频已经可以播放了,我们就可以调⽤用play⽅方法播放了。
 loadedTimeRange属性代表已经缓冲的进度,监听此属性可以在UI中更新缓冲进度,也是很有⽤用的⼀一个属性。
 最后添加⼀一个通知,⽤用于监听视频是否已经播放完毕,然后实现KVO的⽅方法:
 */




/**
 *  通过KVO监控播放器状态
 *
 *  @param keyPath 监控属性
 *  @param object  是我们 监听的对象
 *  @param change  里面包含了keyPath对应的新值
 *  @param context 是 我们 开启监听时 传入的indexPath
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay){
            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
        } else if (status == AVPlayerStatusUnknown) {
            NSLog(@"AVPlayerStatusUnknown");
        } else if (status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f",totalBuffer);
        //
    }
}




// 图片地址判断
- (NSString *)judgePicture
{
    __block NSString *strr;
    
    if (self.musicValue.logo.length == 71) {
        
        NSString *str = [[self.dataArr[self.numberPre] logo] substringToIndex:[self.dataArr[self.numberPre] logo].length - 6];
        strr = [str stringByAppendingString:@"4.jpeg"];
        
    } else {
        
        NSString *str = [[self.dataArr[self.numberPre] logo] substringToIndex:[self.dataArr[self.numberPre] logo].length - 5];
        strr = [str stringByAppendingString:@"4.jpg"];
    }
    return strr;
}



- (void)barButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark ----- 解析歌词 -----
- (void)initLRC
{
    // 获取歌词的网络路径
    NSURL *url = [NSURL URLWithString:[self.dataArr[self.numberPre] lyric_file]];
    NSString *contentStr = [NSString stringWithContentsOfURL:url usedEncoding:nil error:nil];
    
    // 以换行分割歌词, 存入数组
    NSArray *array = [contentStr componentsSeparatedByString:@"\n"];
    
    for (int i = 0; i < [array count]; i++) {
        NSString *linStr = [array objectAtIndex:i];
        NSArray *lineArray = [linStr componentsSeparatedByString:@"]"];
        
        if ([lineArray[0] length] > 8) {
            NSString *str1 = [linStr substringWithRange:NSMakeRange(3, 1)];
            NSString *str2 = [linStr substringWithRange:NSMakeRange(6, 1)];
            if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                
                for (int i = 0; i < lineArray.count - 1; i++) {
                    
                    NSString *lrcStr = [lineArray objectAtIndex:lineArray.count - 1];
                    
                    //分割区间求歌词时间
                    NSString *timeStr = [self timeToSecond:[[lineArray objectAtIndex:i] substringWithRange:NSMakeRange(1, 5)]];
                    self.LRCDictionary = [NSMutableDictionary dictionary];
                    
                    //把时间 和 歌词 加入词典
                    [self.LRCDictionary setObject:lrcStr forKey:timeStr];
                    
                    [self.lrcArray addObject:self.LRCDictionary];
                    
                }
            }
        }
    }
    [self sortLRC:self.lrcArray];
    for (NSDictionary *dic in self.lrcArray) {
        [self.timeArray addObject:[[dic allKeys] objectAtIndex:0]];
    }
    //    NSLog(@"lrcArray: %@", self.lrcArray);
    //    NSLog(@"timeArray: %@", timeArray);
    
}


#pragma mark ---- 把时间转换为秒 ----

// 把时间转换为秒
- (NSString *)timeToSecond:(NSString *)formatTime
{
    NSString * minutes = [formatTime substringWithRange:NSMakeRange(0, 2)];
    NSString * second = [formatTime substringWithRange:NSMakeRange(3, 2)];
    int finishSecond = minutes.intValue * 60 + second.intValue;
    return [NSString stringWithFormat:@"%d",finishSecond];
}



// 以时间顺序进行排序
-(void)sortLRC:(NSMutableArray *)array
{
    for (int i = 0; i < array.count - 1; i++)
    {
        for (int j = i + 1; j < array.count; j++)
        {
            id firstDic = [array objectAtIndex:(NSUInteger )i];
            id secondDic = [array objectAtIndex:(NSUInteger)j];
            NSString *firstTime = [[firstDic allKeys] objectAtIndex:0];
            NSString *secondTime = [[secondDic allKeys] objectAtIndex:0];
            
            // 第一句时间大于第二句，就要进行交换
            if (firstTime.intValue > secondTime.intValue) {
                
                [array replaceObjectAtIndex:(NSUInteger )i withObject:secondDic];
                [array replaceObjectAtIndex:(NSUInteger )j withObject:firstDic];
            }
        }
    }
}





#pragma mark ---- 动态显示歌词 ----
- (void)displayLRC:(NSUInteger)time
{
    
    for (int i = 0; i < [self.timeArray count]; i++) {
        
        NSUInteger currentTime = [self.timeArray[i] intValue];
        
        // 判断是否是最后一句, 如果是, 求最后一句歌词的时间点
        if (i == [self.timeArray count]-1) {
            
            NSUInteger currentTime1 = [self.timeArray[self.timeArray.count-1] intValue];
            if (time > currentTime1) {
                [self updateLrcTableView:i];
                break;
            }
            
        } else {
            
            // 刚开始歌词的状态
            // 求出第一句的时间点，在第一句显示前的时间内一直加载第一句
            
            NSUInteger currentTime2 = [self.timeArray[0] intValue];
            if (time < currentTime2) {
                [self updateLrcTableView:0];
                break;
            }
            
            //求出下一步的歌词时间点，然后计算区间
            NSUInteger currentTime3 = [self.timeArray[i+1] intValue];
            if (time >= currentTime && time <= currentTime3) {
                [self updateLrcTableView:i];
                break;
            }
        }
    }
}

#pragma mark ---- 动态更新歌词表歌词 ----
- (void)updateLrcTableView:(NSUInteger)lineNumber
{
    // 重新载入 歌词列表lrcTabView
    self.lrcLineNumber = lineNumber;
    [self.lrcTableView reloadData];
    
    // 使被选中的行移到中间
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lineNumber inSection:0];
    [self.lrcTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}



// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35/375.0*SCREEN_WIDTH;
}



#pragma mark ----tableViewDelegate----

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.timeArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LRCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //该表格选中后没有颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row == self.lrcLineNumber) {
        NSDictionary *dic = [self.lrcArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [[dic allValues] objectAtIndex:0];
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
    } else {
        
        NSDictionary *dic = [self.lrcArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [[dic allValues] objectAtIndex:0];
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}



#pragma mark ---- 更新播放器 ----

//更新播放器设置
- (void)updatePlayerSetting {
    
    self.avplayer = [AVAplayer defaultAvPlayer];
    
    [self.avplayer playWithUrl:[NSURL URLWithString:[self.dataArr[self.numberPre] listen_file]]];
    
    
    [self addObserverToPlayerItem:self.avplayer.currentItem];
    
    
    // 设置后台播放模式
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    
    // 重新载入歌词词典
    self.timeArray = [NSMutableArray array];
    self.lrcArray = [NSMutableArray array];
    self.LRCDictionary = [NSMutableDictionary dictionary];
    
    // 进行判断是否有歌词路径
    if ([self.dataArr[self.numberPre] lyric_file] != nil) {
        [self initLRC];
    }
    
    
    [self.lrcTableView reloadData];
    
    [self.avplayer play];
}

// TODO 监控播放按钮状态

- (void)playButtonState
{
    if (self.avplayer.rate == 0) {
        
        [self.avplayerView.buttonPlay setImage:[[UIImage imageNamed:@"playing_btn_pause_n.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
    } else if (self.avplayer.rate != 0) {
        
        [self.avplayerView.buttonPlay setImage:[[UIImage imageNamed:@"playing_btn_play_n.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
}



#pragma mark ----- 自动下一首方法 ------

// 播放一首结束之后,自动切换下一曲
- (void)playbackFinished:(NSNotification *)notification
{
    [self buttonNextAction];
}



// 监听播放到多少秒
- (void)changeTimer
{
    // 时时监听

    float value = CMTimeGetSeconds(self.avplayer.currentItem.currentTime) / CMTimeGetSeconds(self.avplayer.currentItem.duration);
    
    self.avplayerView.sliderProgress.value = value;

    CGFloat timer1 = CMTimeGetSeconds(self.avplayer.currentItem.currentTime);
    self.avplayerView.labelCurrentTime.text = [NSString stringWithFormat:@"%@", [self convertTime:timer1]];
    
    [self displayLRC:timer1];
    
}


- (void)changeTimerValue:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    float value = slider.value;
    int32_t timer = self.avplayer.currentItem.asset.duration.timescale;
    CGFloat timeValue = CMTimeGetSeconds(self.avplayer.currentItem.duration) * value;
    [self.avplayer seekToTime:CMTimeMakeWithSeconds(timeValue, timer) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
//    CGFloat timer1 = CMTimeGetSeconds(self.avplayer.currentItem.duration);
    self.avplayerView.labelCurrentTime.text = [NSString stringWithFormat:@"%@", [self convertTime:timeValue]];
    
    [self.avplayer play];
    
}


// 将音频的秒数转换为分钟数
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second / 3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}



#pragma mark ---- 播放按钮方法 buttonPlayAction ----


// 开始播放的方法
- (void)buttonPlayAction
{
    [self.avplayerView.buttonPlay setImage:[[UIImage imageNamed:@"playing_btn_pause_n.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [self.avplayerView.buttonPlay addTarget:self action:@selector(buttonPauseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.avplayer play];
}


#pragma mark ---- 暂停按钮方法 -----


// 暂停播放的方法
- (void)buttonPauseAction
{
    [self.avplayerView.buttonPlay setImage:[[UIImage imageNamed:@"playing_btn_play_n.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.avplayerView.buttonPlay addTarget:self action:@selector(buttonPlayAction) forControlEvents:UIControlEventTouchUpInside];
    [self.avplayer pause];
}

#pragma mark ---- 上一首方法 -----



// 上一首按钮方法
- (void)buttonPreAction
{
    
    
    if (self.numberPre > 0) {

        self.numberPre--;
        
        self.musicValue = [self.dataArr objectAtIndex:self.numberPre];
        
        self.title = self.musicValue.song_name;
        
        self.avplayerView.labelTotalTime.text = [self convertTime:[self.musicValue.play_seconds floatValue]];
        
        // remove KVO
        [self removeObserverFromPlayerItem:self.avplayer.currentItem];

        [self updatePlayerSetting];
        
        NSLog(@"7777777 %ld", (long)self.numberPre);

    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"亲, 已经到第一首了哦" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [self.view addSubview:alertView];
        [alertView show];
        
        NSLog(@"88888888 %ld", (long)self.numberPre);
    }
}



#pragma mark ---- 下一首方法 -----

// 下一首按钮方法
- (void)buttonNextAction
{
    if (self.numberPre < self.dataArr.count - 1) {
        self.numberPre ++;
        
        self.musicValue = [self.dataArr objectAtIndex:self.numberPre];
        
        self.title = self.musicValue.song_name;
        
        self.avplayerView.labelTotalTime.text = [self convertTime:[self.musicValue.play_seconds floatValue]];
        
        // remove KVO
        [self removeObserverFromPlayerItem:self.avplayer.currentItem];
        
        NSLog(@"666666 %ld", (long)self.numberPre);
        NSLog(@"777777 %lu", self.dataArr.count - 1);
        
        [self updatePlayerSetting];
        
    } else if (self.numberPre == self.dataArr.count - 1) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"已经是最后一首了哦, 亲!" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [self.view addSubview:alertView];
        [alertView show];
    }
    
}


@end
