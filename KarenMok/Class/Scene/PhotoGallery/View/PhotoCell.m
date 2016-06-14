//
//  Phot0Cell.m
//  KarenMok
//
//  Created by BraveMatch on 15/1/21.
//  Copyright (c) 2015年 BraveMatch. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageViewBottom = [[UIImageView alloc] init];
//        self.imageViewBottom.backgroundColor = [UIColor redColor];
//        self.imageViewBottom.center = CGPointMake(375/2, 667/2/2);
        self.imageViewBottom.image = [UIImage imageNamed:@"profile_album.png"];
        [self.contentView addSubview:self.imageViewBottom];
        
        self.imageViewHome = [[UIImageView alloc] init];
//        self.imageViewHome.backgroundColor = [UIColor orangeColor];
        [self.imageViewBottom addSubview:self.imageViewHome];
        
        self.labelTitle = [[UILabel alloc] init];
//        self.labelTitle.backgroundColor = [UIColor brownColor];
        [self.contentView addSubview:self.labelTitle];
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageViewBottom.frame = CGRectMake(20, 0, self.frame.size.width - 40, self.frame.size.height);
    self.imageViewHome.frame = CGRectMake(20, 20, self.imageViewBottom.frame.size.width - 40, self.imageViewBottom.frame.size.height - 40);
//    self.labelTitle.frame = CGRectMake(0, 667/2 - 20, 375, 20);
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
