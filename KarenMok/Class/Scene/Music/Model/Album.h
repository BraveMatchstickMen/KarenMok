//
//  Album.h
//  KarenMok
//
//  Created by BraveMatch on 15/1/27.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface Album : BaseObject

@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *album_name;
@property (nonatomic, strong) NSString *publishtime;
@property (nonatomic, strong) NSString *logo;


@end



/*

 {
 "artist_name": "莫文蔚",
 "album_id": 509307262,
 "artist_id": 2017,
 "description": "
 
 
 
 所有的离别 都是为了再见
 今年年底 约定
 Karen莫文蔚 不散，不见
 
 C...",
 "album_name": "不散, 不见",
 "song_count": 11,
 "language": "国语",
 "gmt_publish": 1419523200,
 "company": "环球唱片",
 "sub_title": "",
 "is_check": 0,
 "category": 2,
 "cd_count": 1,
 "logo": "http://img.xiami.net/images/album/img17/2017/5093072621419573206_1.jpeg",
 "is_play": 1,
 "recommends": 153,
 "collects": 5456,
 "status": 1,
 "check_rate": true,
 "play_count": 3351661,
 "publishtime": "2014年12月26日",
 "rec_note": null
 },

*/