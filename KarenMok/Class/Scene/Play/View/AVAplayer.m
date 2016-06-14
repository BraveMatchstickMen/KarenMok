//
//  AVAplayer.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/23.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "AVAplayer.h"

@interface AVAplayer ()

@property (nonatomic, strong) AVPlayerItem *item;

@end


@implementation AVAplayer


+ (AVAplayer *)defaultAvPlayer
{
    static AVAplayer *avplayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        avplayer = [[AVAplayer alloc] init];
    });
    return avplayer;
    
}

- (void)playWithUrl:(NSURL *)url
{
    self.item = [[AVPlayerItem alloc] initWithURL:url];
    [self replaceCurrentItemWithPlayerItem:self.item];
    [self play];
}




@end
