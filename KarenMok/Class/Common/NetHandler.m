//
//  NetHandler.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/23.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//


#import "NetHandler.h"

@implementation NetHandler
+ (void)getDataWithUrl:(NSString *)str completion:(void (^)(id data))block
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                //当为手机蜂窝数据网和WiFi时
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *url = [NSURL URLWithString:urlStr];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
                request.HTTPMethod = @"GET";
                // 建立连接(异步处理)
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    // 处理数据
                    // 1.确定地址
                    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                    NSString *path = [NSString stringWithFormat:@"%@/%ld.aa", docPath, (unsigned long)[str hash]];
                    
                    if (data != nil) {
                        BOOL result = [NSKeyedArchiver archiveRootObject:data toFile:path];
                        //            NSLog(@"%d", result);
                        if (result == NO) {
                            NSLog(@"数据请求失败");
                        }
                        // 当返回的数据不为空时, 调用block
                        block(data);
                    } else {
                        // 没有网络或请求失败, 就从本地读取最近一次成功的数据
                        NSData *pickData = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                        if (pickData != nil) {
                            // 确保有数据才返回
                            block(pickData);
                        }
                    }
                    // 让有关视图 刷新数据
                    // tableView reloadData
                    // label.text = ...
                }];

            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:

            {
                NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *url = [NSURL URLWithString:urlStr];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
                request.HTTPMethod = @"GET";
                // 建立连接(异步处理)
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    // 处理数据
                    // 1.确定地址
                    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                    NSString *path = [NSString stringWithFormat:@"%@/%ld.aa", docPath, (unsigned long)[str hash]];
                    
                    if (data != nil) {
                        BOOL result = [NSKeyedArchiver archiveRootObject:data toFile:path];
                        //            NSLog(@"%d", result);
                        if (result == NO) {
                            NSLog(@"数据请求失败");
                        }
                        // 当返回的数据不为空时, 调用block
                        block(data);
                    } else {
                        // 没有网络或请求失败, 就从本地读取最近一次成功的数据
                        NSData *pickData = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                        if (pickData != nil) {
                            // 确保有数据才返回
                            block(pickData);
                        }
                    }
                }];

            }
                break;
                
                //其它情况
                //当网络不可用（无网络或请求延时）
            case AFNetworkReachabilityStatusNotReachable:
            {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"小小示" message:@"咦, 网不翼而飞了, 请检查网络" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alertView show];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [alertView dismissWithClickedButtonIndex:0 animated:YES];
                });
                
//                [alertView release];
                NSLog(@"当前无网络");
                // 没有网络或请求失败, 就从本地读取最近一次成功的数据
                NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *path = [NSString stringWithFormat:@"%@/%ld.aa", docPath, (unsigned long)[str hash]];
                NSData *pickData = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                if (pickData != nil) {
                    // 确保有数据才返回
                    block(pickData);
                }
                
            }
                break;
            default:
            {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"小小示" message:@"咦, 网不翼而飞了, 请检查网络" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alertView show];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [alertView dismissWithClickedButtonIndex:0 animated:YES];
                });
                
//                [alertView release];
                NSLog(@"当前无网络");
                // 没有网络或请求失败, 就从本地读取最近一次成功的数据
                NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *path = [NSString stringWithFormat:@"%@/%ld.aa", docPath, (unsigned long)[str hash]];
                NSData *pickData = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                if (pickData != nil) {
                    // 确保有数据才返回
                    block(pickData);
                }
            }
                break;
        }
    }];
}
@end
