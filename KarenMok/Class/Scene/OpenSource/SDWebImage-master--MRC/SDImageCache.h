/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDImageCacheDelegate.h"

@interface SDImageCache : NSObject
{
    NSMutableDictionary *memCache;//内存缓存图片引用
    NSString *diskCachePath;//物理缓存路径
    NSOperationQueue *cacheInQueue, *cacheOutQueue;
}

+ (SDImageCache *)sharedImageCache;

//保存图片
- (void)storeImage:(UIImage *)image forKey:(NSString *)key;

//保存图片，并选择是否保存到物理存储上
- (void)storeImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk;

//保存图片，可以选择把NSData数据保存到物理存储上
- (void)storeImage:(UIImage *)image imageData:(NSData *)data forKey:(NSString *)key toDisk:(BOOL)toDisk;

//通过key返回UIImage
- (UIImage *)imageFromKey:(NSString *)key;

//如果获取内存图片失败，是否可以在物理存储上查找
- (UIImage *)imageFromKey:(NSString *)key fromDisk:(BOOL)fromDisk;


- (void)queryDiskCacheForKey:(NSString *)key delegate:(id <SDImageCacheDelegate>)delegate userInfo:(NSDictionary *)info;

//清除key索引的图片
- (void)removeImageForKey:(NSString *)key;
//清除内存图片
- (void)clearMemory;
//清除物理缓存
- (void)clearDisk;
//清除过期物理缓存
- (void)cleanDisk;

@end
