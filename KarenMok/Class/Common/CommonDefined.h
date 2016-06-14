//
//  CommonDefined.h
//
//
//  Created by BraveMatch on 14-8-30.
//  Copyright (c) 2014年  BraveMatch.  All rights reserved.
//



#pragma mark --------日志设置 Log ---------

#define __DEBUG_LOG_ENABLED__ 1

#if __DEBUG_LOG_ENABLED__

#define NSLog(s, ...) NSLog(@"DEBUG %s(%d): %@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])

#else

#define NSLog(s, ...)

#endif



#pragma mark -----UI布局-----

#define SCREEN_WIDTH self.view.frame.size.width
#define SCREEN_HEIGHT self.view.frame.size.height


#pragma mark -----cell重用标识-----



#pragma mark -----KarenMokAPIUrl-----


#define HotMusicAPI @"http://spark.api.xiami.com/api?api_key=655bdb5fc1e0d21a53fce2cb8e1ba0ae&api_sig=0ccd613e3ac2e1cb2d178aff7b6ad11a&app_v=4050000&av=ios_4.5.0&call_id=1421974653.467581&ch=201200&device_id=839385DD-062B-4219-835A-901DAFCABAE9&id=2017&lg=1&method=Artists.hotSongs&network=1&platform_id=2&utdid=VDYSxx2nzDMDAP6V6l4WGNKt&v=1.1"

#define AlbumAPI @"http://spark.api.xiami.com/api?app_v=4050000&method=Search.summary&api_sig=ad9b1750fed3b9087e9aae1e9aa0dc2b&limit=20&lg=1&api_key=655bdb5fc1e0d21a53fce2cb8e1ba0ae&device_id=839385DD-062B-4219-835A-901DAFCABAE9&platform_id=2&key=莫文蔚&proxy=0&ch=201200&is_pub=all&call_id=1422343003.697574&v=1.1&network=1&"


#pragma mark -----用户信息 key-----



#pragma mark -------归档--------



#pragma mark -------通知--------



#pragma mark -----读取本地文件-----

#define LOADTXT(FILENAME) [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:FILENAME ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil]

