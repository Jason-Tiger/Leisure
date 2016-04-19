//
//  RadioPublicView.m
//  Leisure
//
//  Created by 若愚 on 16/2/22.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RadioPublicView.h"

@implementation RadioPublicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.allLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 64 - 1 - 15 - 1, KScreenWidth, 2)];
        self.allLine.backgroundColor = [UIColor clearColor];
        [self addSubview:_allLine];
        
        self.line1 = [[UIView alloc]initWithFrame:CGRectMake((KScreenWidth - 15 * 7) / 2, 0, 15, 2)];
        self.line1.backgroundColor = [UIColor blackColor];
        [self.allLine addSubview:_line1];
        
        self.line2 = [[UIView alloc]initWithFrame:CGRectMake((KScreenWidth - 15 * 7) / 2 + 30, 0, 15, 2)];
        self.line2.backgroundColor = [UIColor blackColor];
        [self.allLine addSubview:_line2];
        
        self.line3 = [[UIView alloc]initWithFrame:CGRectMake((KScreenWidth - 15 * 7) / 2 + 30 + 30, 0, 15, 2)];
        self.line3.backgroundColor = [UIColor blackColor];
        [self.allLine addSubview:_line3];
        
        self.line4 = [[UIView alloc]initWithFrame:CGRectMake((KScreenWidth - 15 * 7) / 2 + 30 + 30 + 30, 0, 15, 2)];
        self.line4.backgroundColor = [UIColor blackColor];
        [self.allLine addSubview:_line4];
        
        self.longline = [[UIView alloc]initWithFrame:CGRectMake(40, frame.size.height - 64 - 1 - 10 - 1 + 1 + 10, KScreenWidth - 80, 1)];
        self.longline.backgroundColor = [UIColor grayColor];
        [self addSubview:_longline];
        
        self.upButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.upButton.frame = CGRectMake(60, frame.size.height - 20 - 24, 24, 24);
        [self.upButton setBackgroundImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        [self addSubview:_upButton];
        
        self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.nextButton.frame = CGRectMake(KScreenWidth - 60 - 24, frame.size.height - 20 - 24, 24, 24);
        [self.nextButton setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        [self addSubview:_nextButton];
        
        self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.playButton.frame = CGRectMake((KScreenWidth - 40) / 2, frame.size.height - 12 - 40, 40, 40);
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play1"] forState:UIControlStateNormal];
        [self addSubview:_playButton];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
