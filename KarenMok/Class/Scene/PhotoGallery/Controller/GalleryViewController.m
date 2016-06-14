//
//  GalleryViewController.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/21.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "GalleryViewController.h"

#define Width 300/375.0*SCREEN_WIDTH
#define Heitht 500/667.0*SCREEN_HEIGHT
#define ImageCount self.imageArr.count


@interface GalleryViewController ()<UIScrollViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *CenterImageView;
@property (nonatomic, strong) UIImageView *RightImageView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger currentImageIndex;
@property (nonatomic, strong) UIScrollView *leftScroll;
@property (nonatomic, strong) UIScrollView *centerScroll;
@property (nonatomic, strong) UIScrollView *rightScroll;

@property (nonatomic, strong) MBProgressHUD *HUD;



@end

@implementation GalleryViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
//    self.view.alpha = 0.8;
    
    
    // 返回按钮
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonBack.frame = CGRectMake(20, 610/667.0*SCREEN_HEIGHT, 40/375.0*SCREEN_WIDTH, 40/375.0*SCREEN_WIDTH);
    [buttonBack setImage:[[UIImage imageNamed:@"mok.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
    
    
    // create a big UIScrollView which rolling pictures
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(38, 40, Width, Heitht)];
    self.scrollView.contentSize = CGSizeMake(Width * 3, Heitht);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView setContentOffset:CGPointMake(Width, 0) animated:NO];
    self.scrollView.delegate = self;
    
    
    
    // create left scrollView 
    self.leftScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width, Heitht)];
    self.leftScroll.minimumZoomScale = 0.6;
    self.leftScroll.maximumZoomScale = 3;
    self.leftScroll.delegate = self;
    
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Heitht)];
    
    // 图片处理
    NSString *str = [self.imageArr objectAtIndex:self.imageArr.count - 1];
    NSURL *pic_url = [NSURL URLWithString:str];
    [self handlerImage:pic_url imageView:self.leftImageView];
    
    [self.leftScroll addSubview:self.leftImageView];
    [self.scrollView addSubview:self.leftScroll];
    
    
    self.centerScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(Width, 0, Width, Heitht)];
    self.centerScroll.minimumZoomScale = 0.6;
    self.centerScroll.maximumZoomScale = 3;
    self.centerScroll.delegate = self;
    
    self.CenterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Heitht)];
    
    NSString *strCenter = [self.imageArr objectAtIndex:self.currentImageIndex];
    NSURL *urlCenter = [NSURL URLWithString:strCenter];
    [self handlerImage:urlCenter imageView:self.CenterImageView];

    [self.centerScroll addSubview:self.CenterImageView];
    [self.scrollView addSubview:self.centerScroll];
    

    // 设置rightScroll
    self.rightScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(Width * 2, 0, Width, Heitht)];
    self.rightScroll.minimumZoomScale = 0.6;
    self.rightScroll.maximumZoomScale = 3;
    self.rightScroll.delegate = self;
    
    self.RightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Heitht)];
    
    NSString *strRight = [self.imageArr objectAtIndex:1];
    NSURL *urlRight = [NSURL URLWithString:strRight];
    [self handlerImage:urlRight imageView:self.RightImageView];
    
    
    [self.rightScroll addSubview:self.RightImageView];
    [self.scrollView addSubview:self.rightScroll];
    
    [self.view addSubview:self.scrollView];

    // 设置pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(20, 594/667.0*SCREEN_HEIGHT, 335/375.0*SCREEN_WIDTH, 30/667.0*SCREEN_HEIGHT)];
    self.pageControl.numberOfPages = ImageCount;
    [self.view addSubview: self.pageControl];
    self.pageControl.currentPage = self.currentImageIndex;

    // 设置加载图片的菊花
    [self setMBProgressHUD];
    
}


- (void)setMBProgressHUD
{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    
    // Set determinate bar mode
    self.HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    
    self.HUD.delegate = self;
    
    // myProgressTask uses the HUD instance to update progress
    [self.HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}


- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        self.HUD.progress = progress;
        usleep(50000);
    }
}


/**
 *  自定义的方法:处理图片数据
 *
 *  @param pic_url   图片网络地址
 *  @param imageView 图片放在哪一个imageView上
 */
- (void)handlerImage:(NSURL *)pic_url imageView:(UIImageView *)imageView
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:pic_url];
    
    __block UIImageView *imageV = imageView;
    __block GalleryViewController *own = self;
    
    [imageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"like.jpg"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        imageV.image = image;
        
        [own.HUD hide:YES];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];

}




// 返回按钮方法
- (void)buttonAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
{
    return [scrollView.subviews firstObject];
}



#pragma mark 当图片小于屏幕宽高时缩放后让图片显示到屏幕中间
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize originalSize = self.centerScroll.bounds.size;
    CGSize contentSize = self.centerScroll.contentSize;
    CGFloat offsetX = originalSize.width > contentSize.width ? (originalSize.width - contentSize.width)/2 : 0;
    CGFloat offsetY = originalSize.height>contentSize.height?(originalSize.height-contentSize.height)/2 : 0;
    
    self.CenterImageView.center = CGPointMake(contentSize.width/2 + offsetX, contentSize.height/2 + offsetY);
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //重新加载图片
    [self reloadImage];
    //移动到中间
    [self.scrollView setContentOffset:CGPointMake(Width, 0) animated:NO];
    
    self.pageControl.currentPage = self.currentImageIndex;
    
}


-(void)reloadImage
{
    NSInteger leftImageIndex,rightImageIndex;
    NSInteger number = self.scrollView.contentOffset.x;
    
//    NSLog(@"number: %ld", number);
    
    if (number > Width) {
        self.currentImageIndex = (self.currentImageIndex + 1) % ImageCount;
    } else if(number < Width) {
        self.currentImageIndex = (self.currentImageIndex + ImageCount - 1) % ImageCount;
    }
//    NSLog(@"currentImageIndex: %ld",self.currentImageIndex);
    
//    self.CenterImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)self.currentImageIndex]];
    
    
    NSString *strCenter = [self.imageArr objectAtIndex:self.currentImageIndex];
    NSURL *urlCenter = [NSURL URLWithString:strCenter];
//    [self.CenterImageView setImageWithURL:urlCenter];
    [self handlerImage:urlCenter imageView:self.CenterImageView];

    
    //重新设置左右图片
    leftImageIndex = (self.currentImageIndex + ImageCount - 1) % ImageCount;
    rightImageIndex = (self.currentImageIndex + 1) % ImageCount;
//    self.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)leftImageIndex]];
//    self.RightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)rightImageIndex]];
    
    
    NSString *str = [self.imageArr objectAtIndex:leftImageIndex];
    NSURL *url = [NSURL URLWithString:str];
//    [self.leftImageView setImageWithURL:url];
    [self handlerImage:url imageView:self.leftImageView];
    
    
    NSString *str1 = [self.imageArr objectAtIndex:rightImageIndex];
    NSURL *url1 = [NSURL URLWithString:str1];
//    [self.RightImageView setImageWithURL:url1];
    [self handlerImage:url1 imageView:self.RightImageView];
    
    
    self.leftScroll.zoomScale = 1;
    self.rightScroll.zoomScale = 1;
    self.centerScroll.zoomScale = 1;
    
}

@end
