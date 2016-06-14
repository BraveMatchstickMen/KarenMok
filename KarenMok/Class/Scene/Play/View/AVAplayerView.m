//
//  AVAplayerView.m
//  KarenMok
//
//  Created by BraveMatch on 15/3/4.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "AVAplayerView.h"

@interface AVAplayerView ()


@end

@implementation AVAplayerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self p_setupSubviews];
    }
    return self;
}


- (void)p_setupSubviews
{
    
    // 播放页面背景
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = [UIScreen mainScreen].bounds;
    self.imageView.userInteractionEnabled = YES;
    [self addSubview:self.imageView];
    
    // 为imageView添加高斯模糊子视图
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualEffectView.frame = self.imageView.bounds;
    [self.imageView addSubview:visualEffectView];

    // logo
    self.imageViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 220/375.0*self.frame.size.width, 250/667.0*self.frame.size.height)];
    self.imageViewLogo.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 80/667.0*self.frame.size.height);
    self.imageViewLogo.layer.cornerRadius = 10;
    self.imageViewLogo.layer.masksToBounds = YES;
    
    [self addSubview:self.imageViewLogo];
    
    // TODO 监听播放按钮状态
    
    // 开始播放按钮
    self.buttonPlay = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonPlay.center = CGPointMake(self.frame.size.width/2, 607/667.0*self.frame.size.height);
    self.buttonPlay.bounds = CGRectMake(0, 0, 60/375.0*self.frame.size.width, 60/375.0*self.frame.size.width);
    [self.buttonPlay setImage:[[UIImage imageNamed:@"playing_btn_pause_n.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [self addSubview:self.buttonPlay];
    
    // 上一首按钮
    self.buttonPre = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonPre.frame = CGRectMake(self.frame.size.width/2-130/375.0*self.frame.size.width, self.frame.size.height - 80/667.0*self.frame.size.height, 40/375.0*self.frame.size.width, 40/375.0*self.frame.size.width);
    [self.buttonPre setImage:[[UIImage imageNamed:@"playing_btn_pre_n.png" ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [self addSubview:self.buttonPre];
    
    
    // 下一首按钮
    self.buttonNext = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.buttonNext.center = CGPointMake(self.frame.size.width/2+110/375.0*self.frame.size.width, self.frame.size.height - 60/667.0*self.frame.size.height);
    self.buttonNext.bounds = CGRectMake(0, 0, 40/375.0*self.frame.size.width, 40/375.0*self.frame.size.width);
    [self.buttonNext setImage:[[UIImage imageNamed:@"playing_btn_next_n.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    
    [self addSubview:self.buttonNext];
    
    
    // 进度条
    self.sliderProgress = [[UISlider alloc] initWithFrame:CGRectMake(-30/375.0*self.frame.size.width, self.frame.size.height-140/667.0*self.frame.size.height, 435/375.0*self.frame.size.width, 20)];
    
    //    TODO 滑动块不能到头
    
    UIImage *thumb = [UIImage imageNamed:@"sliderThumb_small.png"];
    
    [self.sliderProgress setThumbImage:thumb forState:UIControlStateNormal];
    
    [self.sliderProgress setThumbImage:thumb forState:UIControlStateHighlighted];
    
    self.sliderProgress.continuous = YES;
    
    [self addSubview:self.sliderProgress];
    
    // 当前时间
    self.labelCurrentTime = [[UILabel alloc] initWithFrame:CGRectMake(20, self.frame.size.height-120/667.0*self.frame.size.height, 50/375.0*self.frame.size.width, 20)];
    self.labelCurrentTime.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:self.labelCurrentTime];
    
    // 总共的时间
    self.labelTotalTime = [[UILabel alloc] initWithFrame:CGRectMake(315/375.0*self.frame.size.width, 547/667.0*self.frame.size.height, 50/375.0*self.frame.size.width, 20)];
    //    self.labelTotalTime.backgroundColor = [UIColor redColor];

    self.labelTotalTime.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.labelTotalTime];
    
}


@end
