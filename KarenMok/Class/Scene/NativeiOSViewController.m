//
//  TestViewController.m
//  KarenMok
//
//  Created by 柴勇峰 on 6/17/16.
//  Copyright © 2016 BraveMatch. All rights reserved.
//

#import "NativeiOSViewController.h"

@interface NativeiOSViewController ()
{
    UIImageView *_imageView;
    
    UILabel *_title;
}

@end

@implementation NativeiOSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   self.title = @"native ios page";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setSubviews];
}

- (void)setSubviews
{
    _imageView = ({
       
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(60, 100, 320-120, 300);
        [imageView setImageWithURL:[NSURL URLWithString:_dictionary[@"posters"][@"thumbnail"]]];
        [self.view addSubview:imageView];
        imageView;
    });
    
    _title = ({
       
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(0, 450, 320, 40);
        lable.font = [UIFont systemFontOfSize:24.f];
        lable.textAlignment = NSTextAlignmentCenter;
        [lable setText:_dictionary[@"title"]];
        [self.view addSubview:lable];
        lable;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
