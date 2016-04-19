//
//  RadioPlayTwoController.m
//  Leisure
//
//  Created by 若愚 on 16/2/22.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//


#import "RadioPlayTwoController.h"



@interface RadioPlayTwoController ()


@end

@implementation RadioPlayTwoController

#pragma mark -- 自定义初始化 --
- (instancetype)initWithCoverimg:(NSString *)coverimg myTitle:(NSString *)myTitle
{
    self = [super init];
    if (self) {
        self.coverimg = coverimg;
        self.myTitle = myTitle;
    }
    return self;
}

#pragma mark -- 布局 --
- (void)addSubViews
{
    self.mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(45, 45, KScreenWidth - 90, KScreenWidth - 90)];
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:_coverimg]];
    [self.view addSubview:_mainImage];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, KViewHeight - 10 - 20 - 20 - 20 - 20 - 30, KScreenWidth, 30)];
    self.titleLabel.text = _myTitle;
    self.titleLabel.textAlignment = 1;
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17 * Fit];
    [self.view addSubview:_titleLabel];
    
//    self.loveButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.loveButton.frame = CGRectMake((KScreenWidth - 140) / 2, KViewHeight - 10 - 20 - 20 - 20, 20, 20);
//    [self.loveButton setBackgroundImage:[UIImage imageNamed:@"29-heart"] forState:UIControlStateNormal];
//    [self.view addSubview:_loveButton];
//    
//    self.commentButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.commentButton.frame = CGRectMake((KScreenWidth - 140) / 2 + 30 + 100, KViewHeight - 10 - 20 - 20 - 20, 20, 20);
//    [self.commentButton setBackgroundImage:[UIImage imageNamed:@"08-chat"] forState:UIControlStateNormal];
//    [self.view addSubview:_commentButton];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, KViewHeight - 10 - 20, 40, 20)];
    self.timeLabel.font = [UIFont systemFontOfSize:12 * Fit];
    self.timeLabel.textAlignment = 1;
    self.timeLabel.text = @"00:00";
    [self.view addSubview:_timeLabel];
    
    self.maxTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth - 50 - 40, KViewHeight - 10 - 20, 40, 20)];
    self.maxTimeLabel.font = [UIFont systemFontOfSize:12 * Fit];
    self.maxTimeLabel.textAlignment = 1;
    self.maxTimeLabel.text = @"00:00";
    [self.view addSubview:_maxTimeLabel];
    
    self.planSlider = [[UISlider alloc]initWithFrame:CGRectMake(50 + 40 + 10, KViewHeight - 10 - 20, KScreenWidth - 50 * 2 - 40 * 2 - 10 * 2, 20)];
    self.planSlider.minimumTrackTintColor = [UIColor blackColor];
    self.planSlider.maximumTrackTintColor = [UIColor lightGrayColor];
    [self.planSlider setThumbImage:[UIImage imageNamed:@"plan"] forState:UIControlStateNormal];
    [self.view addSubview:_planSlider];
}

#pragma mark -- 加方法 --
- (void)addActions
{
    [self.planSlider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    [self.planSlider addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.player = [PlayerManager shardManager];
    [self addSubViews];
    [self addActions];
}

#pragma mark -- 切歌的时候换界面 --
- (void)setCoverimg:(NSString *)coverimg myTitle:(NSString *)myTitle
{
    _coverimg = coverimg;
    _myTitle = myTitle;
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:coverimg]];
    self.titleLabel.text = myTitle;
}

#pragma mark -- 改变label的进度值 --
- (void)changeValue:(UISlider *)slider
{
    self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (NSInteger)slider.value / 60, (NSInteger)slider.value % 60];
}

#pragma mark -- 改变播放进度 --
- (void)didChangeValue:(UISlider *)slider
{
    [self.player seekToTime:(NSInteger)slider.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
