//
//  AVAplayer.h
//  KarenMok
//
//  Created by BraveMatch on 15/1/23.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVAplayer : AVPlayer

+ (AVAplayer *)defaultAvPlayer;

- (void)playWithUrl:(NSURL *)url;

@end
