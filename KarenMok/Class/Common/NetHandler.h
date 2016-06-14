//
//  NetHandler.h
//
//  KarenMok
//
//  Created by BraveMatch on 15/1/23.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetHandler : NSObject

// 根据网络请求的特点, 不同的地方就是请求地址和分析数据的方式不同, 就把这两部分分别作为方法参数
+ (void)getDataWithUrl:(NSString *)str completion:(void (^)(id data))block;
@end
