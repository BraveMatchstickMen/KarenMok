//
//  BaseObject.m
//  Activity_Lesson_12.3
//
//  Created by 柴勇峰 on 14/12/3.
//  Copyright (c) 2014年 All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject


- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
}





- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}




- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}







@end
