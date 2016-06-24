//
//  RNNotificationManager.m
//  KarenMok
//
//  Created by 柴勇峰 on 6/17/16.
//  Copyright © 2016 BraveMatch. All rights reserved.
//

#import "RNNotificationManager.h"

@implementation RNNotificationManager

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(postNotification:(NSString *)name userInfo:(NSDictionary *)userInfo)
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self userInfo:userInfo];
}

@end
