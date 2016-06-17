//
//  MyCollectViewController.m
//  KarenMok
//
//  Created by 柴勇峰 on 6/14/16.
//  Copyright © 2016 BraveMatch. All rights reserved.
//

#import "NativeViewController.h"
#import "ReactView.h"

@interface NativeViewController ()

//@property (nonatomic, weak) IBOutlet FavoriteMusicView *favoriteView;

@end

@implementation NativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的收藏";
    
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    
    ReactView *reactView = [[ReactView alloc] initWithFrame:self.view.bounds];
    
    reactView.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:reactView];
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
