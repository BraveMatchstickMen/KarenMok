//
//  PlayViewController.h
//  KarenMok
//
//  Created by BraveMatch on 15/1/23.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Music;

@interface PlayViewController : UIViewController

@property (nonatomic, strong) Music *music;

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, assign) NSInteger numberPre;

//+ (PlayViewController *)defaultPlayVC;


@end
