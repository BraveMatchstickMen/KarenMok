//
//  AlbumView.m
//  KarenMok
//
//  Created by BraveMatch on 15/3/5.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "AlbumView.h"

@implementation AlbumView

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
    // 抽屉效果
    self.bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.bounds.size.height)];
    self.bigScrollView.contentSize = CGSizeMake(self.frame.size.width * 3 / 2, 0);
    self.bigScrollView.contentOffset = CGPointMake(self.frame.size.width / 2, 0);
    self.bigScrollView.backgroundColor = [UIColor blackColor];
    self.bigScrollView.pagingEnabled = YES;
    [self addSubview:self.bigScrollView];
    
    
    self.about = [UIButton buttonWithType:UIButtonTypeSystem];
    self.about.frame = CGRectMake(0, 170/667.0*self.frame.size.height, self.frame.size.width/2, 30);
    [self.about setTitle:@"Mok相册" forState:UIControlStateNormal];
    [self.about setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bigScrollView addSubview:self.about];
    
    
    self.photo = [UIButton buttonWithType:UIButtonTypeSystem];
    self.photo.frame = CGRectMake(0, 220/667.0*self.frame.size.height, self.frame.size.width/2, 30);
    [self.photo setTitle:@"经典热曲" forState:UIControlStateNormal];
    [self.photo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bigScrollView addSubview:self.photo];
    
    
    self.mv = [UIButton buttonWithType:UIButtonTypeSystem];
    self.mv.frame = CGRectMake(0, 270/667.0*self.frame.size.height, self.frame.size.width/2, 30);
    [self.mv setTitle:@"MOK MV" forState:UIControlStateNormal];
    [self.mv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bigScrollView addSubview:self.mv];
    
    
    self.hot = [UIButton buttonWithType:UIButtonTypeSystem];
    self.hot.frame = CGRectMake(0, 320/667.0*self.frame.size.height, self.frame.size.width/2, 30);
    [self.hot setTitle:@"关于莫文蔚" forState:UIControlStateNormal];
    [self.hot setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bigScrollView addSubview:self.hot];
    
    
    self.feedBack = [UIButton buttonWithType:UIButtonTypeSystem];
    self.feedBack.frame = CGRectMake(0, 370/667.0*self.frame.size.height, self.frame.size.width/2, 30);
    [self.feedBack setTitle:@"联系我们" forState:UIControlStateNormal];
    [self.feedBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bigScrollView addSubview:self.feedBack];
    
    self.favorite = [UIButton buttonWithType:UIButtonTypeSystem];
    self.favorite.frame = CGRectMake(0, 420/667.0*self.frame.size.height, self.frame.size.width/2, 30);
    [self.favorite setTitle:@"我的收藏" forState:UIControlStateNormal];
    [self.favorite setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bigScrollView addSubview:self.favorite];
}




@end
