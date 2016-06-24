//
//  MyCollectViewController.m
//  KarenMok
//
//  Created by 柴勇峰 on 6/14/16.
//  Copyright © 2016 BraveMatch. All rights reserved.
//

#import "ReactViewController.h"
#import "ReactView.h"
#import "NativeiOSViewController.h"

@interface ReactViewController ()

//@property (nonatomic, weak) IBOutlet FavoriteMusicView *favoriteView;

@end

@implementation ReactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"react page";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reactNotification:) name:@"pushVC" object:nil];
    
    ReactView *reactView = [[ReactView alloc] initWithFrame:self.view.bounds];
    
    reactView.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:reactView];
}

- (void)reactNotification:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"movie: %@", notification.userInfo[@"k"]);
        
        NativeiOSViewController *nativeVC = [[NativeiOSViewController alloc] init];
        
        nativeVC.dictionary = notification.userInfo[@"k"];
        
        [self.navigationController pushViewController:nativeVC animated:YES];
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
