//
//  CommunityDetailHeader.m
//  Leisure
//
//  Created by 若愚 on 16/2/19.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "CommunityDetailHeader.h"

@implementation CommunityDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, KScreenWidth - 40, 30)];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 * Fit];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.text = @"没有可以分享秘密的朋友是什么感觉";
        [self.contentView addSubview:_titleLabel];
        
        self.lz_Image = [[UIImageView alloc]initWithFrame:CGRectMake(20, 35 + 30 + 20, 60, 60)];
        self.lz_Image.backgroundColor = [UIColor orangeColor];
        self.lz_Image.layer.masksToBounds = YES;
        self.lz_Image.layer.cornerRadius = 30;
        [self.contentView addSubview:_lz_Image];
        
        self.lz_nameButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.lz_nameButton.frame = CGRectMake(20 + 60 + 10, 35 + 30 + 20 + 20, 100, 20);
        [self.lz_nameButton setTitle:@"哈哈" forState:UIControlStateNormal];
        [self.lz_nameButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.lz_nameButton.titleLabel.font = [UIFont systemFontOfSize:14 * Fit];
        [self.contentView addSubview:_lz_nameButton];
        
        self.lz_idenLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 + 60 + 10 + 100, 35 + 30 + 20 + 20, 30, 20)];
        self.lz_idenLabel.font = [UIFont systemFontOfSize:12 * Fit];
        self.lz_idenLabel.text = @"楼主";
        self.lz_idenLabel.textColor = [UIColor grayColor];
        self.lz_idenLabel.shadowColor = [UIColor grayColor];
        self.lz_idenLabel.shadowOffset = CGSizeMake(1, 1);
        [self.contentView addSubview:_lz_idenLabel];
        
        self.lz_timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth - 10 - 100, 35 + 30 + 20 + 20, 100, 20)];
        self.lz_timeLabel.font = [UIFont systemFontOfSize:10 * Fit];
        self.lz_timeLabel.text = @"10月22日 15:00";
        self.lz_timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lz_timeLabel];
        
        self.lz_web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 35 + 30 + 20 + 60 + 30, KScreenWidth, KScreenHeight / 3 * 2)];
        [self.contentView addSubview:_lz_web];
        
        self.functionView = [[UIView alloc]initWithFrame:CGRectMake(0, 35 + 30 + 20 + 60 + 30 + KScreenHeight / 3 * 2, KScreenWidth, 50)];
        [self.contentView addSubview:_functionView];
        
        self.line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 1)];
        self.line1.backgroundColor = [UIColor blackColor];
        [self.functionView addSubview:_line1];
        
//        self.onlyLzButton = [UIButton buttonWithType:UIButtonTypeSystem];
//        self.onlyLzButton.backgroundColor = [UIColor grayColor];
//        [self.onlyLzButton setTitle:@"只看楼主" forState:UIControlStateNormal];
//        [self.onlyLzButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.onlyLzButton.titleLabel.font = [UIFont systemFontOfSize:14 * Fit];
//        self.onlyLzButton.frame = CGRectMake(10, 9, (KScreenWidth - 40) / 4, 30);
//        [self.functionView addSubview:_onlyLzButton];
//        
//        self.sortButton = [UIButton buttonWithType:UIButtonTypeSystem];
//        [self.sortButton setTitle:@"顺序浏览评论" forState:UIControlStateNormal];
//        [self.sortButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.sortButton.backgroundColor = [UIColor grayColor];
//        self.sortButton.titleLabel.font = [UIFont systemFontOfSize:14 * Fit];
//        self.sortButton.frame = CGRectMake(10 + (KScreenWidth - 40) / 4 + 10, 9, (KScreenWidth - 40) / 2, 30);
//        [self.functionView addSubview:_sortButton];
//        
//        self.hotButton = [UIButton buttonWithType:UIButtonTypeSystem];
//        [self.hotButton setTitle:@"热门评论" forState:UIControlStateNormal];
//        [self.hotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        self.hotButton.backgroundColor = [UIColor grayColor];
//        self.hotButton.frame = CGRectMake(KScreenWidth - (KScreenWidth - 40) / 4 - 10, 9, (KScreenWidth - 40) / 4, 30);
//        self.hotButton.titleLabel.font = [UIFont systemFontOfSize:14 * Fit];
//        [self.functionView addSubview:_hotButton];
        
        self.line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 35 + 30 + 20 + 60 + 30 + KScreenHeight / 3 * 2 + 50, KScreenWidth, 1)];
        self.line2.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_line2];
    }
    return self;
}

- (void)headerConfigureModel:(CommunityDetailModel *)model
{
        CGRect bounds = [model.title boundingRectWithSize:CGSizeMake(KScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName] context:nil];
        self.titleLabel.frame = CGRectMake(20, 35, KScreenWidth - 40, bounds.size.height);
        self.titleLabel.text = model.title;
        
        self.lz_Image.frame = CGRectMake(20, 35 + bounds.size.height + 20, 60, 60);
        [self.lz_Image sd_setImageWithURL:[NSURL URLWithString:model.lz_icon]];
        
        self.lz_nameButton.frame = CGRectMake(20 + 60 + 10, 35 + bounds.size.height + 20 + 10, 40, 20);
        [self.lz_nameButton setTitle:model.lz_uname forState:UIControlStateNormal];
        
        self.lz_idenLabel.frame = CGRectMake(20 + 60 + 10 + 40, 35 + bounds.size.height + 20 + 10, 30, 20);
        
        self.lz_timeLabel.frame = CGRectMake(KScreenWidth - 10 - 100, 35 + bounds.size.height + 20 + 10, 100, 20);
        self.lz_timeLabel.text = model.lz_addtime_f;
        
        self.lz_web.delegate = self;
        self.lz_web.frame = CGRectMake(0, 35 + bounds.size.height + 20 + 60 + 30, KScreenWidth, KScreenHeight / 3 * 2);
        [self.lz_web loadHTMLString:[NSString importStyleWithHtmlString:model.html] baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
        
        self.functionView.frame = CGRectMake(0, 35 + bounds.size.height + 20 + 60 + 30 + KScreenHeight / 3 * 2, KScreenWidth, 50);
        
        self.line2.frame = CGRectMake(0, 35 + bounds.size.height + 20 + 60 + 30 + KScreenHeight / 3 * 2 + 50, KScreenWidth, 1);
}

+ (CGFloat)heightForHeader:(CommunityDetailModel *)model
{
        CGRect bounds = [model.title boundingRectWithSize:CGSizeMake(KScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName] context:nil];
        return 35 + bounds.size.height + 20 + 60 + 30 + KScreenHeight / 3 * 2 + 50 + 1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
