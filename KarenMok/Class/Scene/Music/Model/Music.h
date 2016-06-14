//
//  Music.h
//  KarenMok
//
//  Created by BraveMatch on 15/1/23.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface Music :BaseObject


@property (nonatomic, strong) NSString *song_name;     // 歌曲名称
@property (nonatomic, strong) NSString *album_name;    // 专辑名称
@property (nonatomic, strong) NSString *listen_file;   // 播放地址
@property (nonatomic, strong) NSString *logo;          // logo
@property (nonatomic, strong) NSString *play_seconds;  // 时长
@property (nonatomic, strong) NSString *lyric_file;    // 歌词地址





/*
 
 {
 "state": 0,
 "data": {
 "songs": [
 {
 "song_id": 135939,
 "song_name": "如果没有你",
 "album_id": 11011,
 "album_name": "如果没有你",
 "artist_id": 2017,
 "artist_name": "莫文蔚",
 "singers": "莫文蔚",
 "length": 289,
 "play_counts": 10351790,
 "recommends": 83,
 "listen_file": "http://m5.file.xiami.com/17/2017/11011/135939_2388951_l.mp3?auth_key=7c04d05c93a4571819f8b8ccc04c5965-1422057600-0-null",
 
 "http://m5.file.xiami.com/17/2017/11020/136064_4394992_l.mp3?auth_key=ef5f874f76728225f833556473b599a5-1422057600-0-null
 
 "demo": 0,
 "lyric": "http://img.xiami.net/lyric/39/135939_14012163309950.lrc",
 "lyric_karaok": "http://img.xiami.net/lyric/karaok/39/135939_1374144115.lrc",
 "logo": "http://img.xiami.net/images/album/img17/2017/110111381716047_1.jpg",
 "res_id": 2388951,
 "track": 3,
 "cd_serial": 1,
 "hash": "12d9aeddfca22565ddadc56a648f72b3",
 "mv_id": "K66oWh",
 "flag": 0,
 "play_seconds": 289,
 "title": "如果没有你",
 "name": "如果没有你",
 "album_logo": "
 http://img.xiami.net/images/album/img17/2017/110111381716047_1.jpg",
 http://img.xiami.net/images/album/img17/2017/110201375852546_1.jpg
 "lyric_file": "http://img.xiami.net/lyric/39/135939_14012163309950.lrc",
 "default_resource_id": 2388951,
 "rec_note": null
 },
 {
 "song_id": 136064,
 "song_name": "忽然之间",
 "album_id": 11020,
 "album_name": "含情莫莫 全精选辑",
 "artist_id": 2017,
 "artist_name": "莫文蔚",
 "singers": "莫文蔚",
 "length": 202,
 "play_counts": 8107372,
 "recommends": 53,
 "listen_file": "http://m5.file.xiami.com/17/2017/11020/136064_4394992_l.mp3?auth_key=ef5f874f76728225f833556473b599a5-1422057600-0-null",
 "demo": 0,
 "lyric": "http://img.xiami.net/lyric/upload/64/136064_1374547983.lrc",
 "lyric_karaok": "http://img.xiami.net/lyric/karaok/64/136064_1374144121.lrc",
 "logo": "http://img.xiami.net/images/album/img17/2017/110201375852546_1.jpg",
 "res_id": 4394992,
 "track": 15,
 "cd_serial": 1,
 "hash": "e52c27763fb0546a719fcb136d599a22",
 "mv_id": "",
 "flag": 0,
 "play_seconds": 202,
 "title": "含情莫莫 全精选辑",
 "name": "忽然之间",
 "album_logo": "http://img.xiami.net/images/album/img17/2017/110201375852546_1.jpg",
 "lyric_file": "http://img.xiami.net/lyric/upload/64/136064_1374547983.lrc",
 "default_resource_id": 4394992,
 "rec_note": null
 },
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {},
 {}
 ]
 },
 "status": "ok",
 "err": null
 }

 
 
 */

@end
