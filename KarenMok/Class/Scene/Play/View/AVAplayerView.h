//
//  AVAplayerView.h
//  KarenMok
//
//  Created by BraveMatch on 15/3/4.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVAplayerView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *imageViewLogo;

@property (nonatomic, strong) UIButton *buttonPlay;
@property (nonatomic, strong) UIButton *buttonPre;
@property (nonatomic, strong) UIButton *buttonNext;
@property (nonatomic, strong) UISlider *sliderProgress;

@property (nonatomic, strong) UILabel *labelCurrentTime;
@property (nonatomic, strong) UILabel *labelTotalTime;

@property (nonatomic, strong) UITableView *lrcTableView;


@end
