//
//  Album.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/27.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "Album.h"

@implementation Album

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.introduction = value;
    }
}



@end
