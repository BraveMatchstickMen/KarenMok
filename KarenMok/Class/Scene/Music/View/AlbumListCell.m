//
//  AlbumListCell.m
//  KarenMok
//
//  Created by BraveMatch on 15/2/6.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "AlbumListCell.h"



@implementation AlbumListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.myImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.myImageView];
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:self.label];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.myImageView.frame = CGRectMake(20, 10, self.frame.size.width/4 - 20, self.frame.size.height - 20);
    self.label.frame = CGRectMake(self.frame.size.width/4+10, 10, self.frame.size.width/2-20, self.frame.size.height-20);
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
