//
//  BasedTableViewController.h
//  KarenMok
//
//  Created by BraveMatch on 15/3/4.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasedTableViewController : UITableViewController

@property (nonatomic,retain) MBProgressHUD * hud;  //loading

//发起网络请求
- (void)sendRequest;


@end
