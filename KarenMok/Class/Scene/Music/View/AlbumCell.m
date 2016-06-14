//
//  AlbumCell.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/27.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubviews];
    }
    return self;
}


- (void)createSubviews
{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(5, 0, self.frame.size.width-10, self.frame.size.height-20);
    [self.contentView addSubview:self.imageView];
    
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.frame = CGRectMake(5, self.frame.size.height-20, self.frame.size.width, 20);
    [self.contentView addSubview:self.labelTitle];
    
}




@end
