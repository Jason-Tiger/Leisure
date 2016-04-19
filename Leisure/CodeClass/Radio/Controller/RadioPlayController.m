//
//  RadioPlayController.m
//  Leisure
//
//  Created by 若愚 on 16/2/23.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RadioPlayController.h"
#import "RadioPublicView.h"


@interface RadioPlayController () <UIScrollViewDelegate, UIWebViewDelegate, RadioPlayOneControllerDelegate>

@property(nonatomic, strong)RadioPublicView *publicView;
@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)PlayerManager *player;

@property(nonatomic, strong)UIButton *playerTypeButton;
@property(nonatomic, strong)UIButton *collectButton;
@property(nonatomic, strong)UIButton *shareButton;
@property(nonatomic, strong)UIButton *timingButton;

@property(nonatomic, strong)NSTimer *timer;

@end

@implementation RadioPlayController

#pragma mark -- 单例 --
+ (instancetype)shardRadioPlayController
{
    static RadioPlayController *radioPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        radioPlayer = [[RadioPlayController alloc]init];
    });
    return radioPlayer;
}

#pragma mark -- 重写init --
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.player = [PlayerManager shardManager];
    }
    return self;
}

//#pragma mark -- 自定义初始化 --
//- (instancetype)initWithRadioid:(NSString *)radioid title:(NSString *)title icon:(NSString *)icon uname:(NSString *)uname coverimg:(NSString *)coverimg desc:(NSString *)desc count:(NSInteger)count  modelArray:(NSMutableArray *)modelArray index:(NSInteger)index
//{
//    self = [super init];
//    if (self) {
//        _radioid = radioid;
//        _myTitle = title;
//        _icon = icon;
//        _uname = uname;
//        _coverimg = coverimg;
//        _desc = desc;
//        _count = [NSString stringWithFormat:@"%ld", count];
//        _modelArray = modelArray;
//        _index = index;
//    }
//    return self;
//}

#pragma mark -- 开交互 --
- (void)openUser
{
    self.view.userInteractionEnabled = YES;
}

#pragma mark -- 重新赋值 --
- (void)setRadioid:(NSString *)radioid title:(NSString *)title icon:(NSString *)icon uname:(NSString *)uname coverimg:(NSString *)coverimg desc:(NSString *)desc count:(NSInteger)count  modelArray:(NSMutableArray *)modelArray index:(NSInteger)index
{
    _radioid = radioid;
    _myTitle = title;
    _icon = icon;
    _uname = uname;
    _coverimg = coverimg;
    _desc = desc;
    _count = [NSString stringWithFormat:@"%ld", count];
    _modelArray = modelArray;
    _index = index;
    NSMutableArray *musicArray = [NSMutableArray array];
    for (RadioListModel *model in _modelArray) {
        [musicArray addObject:model.musicUrl];
    }
    self.player.musicArray = musicArray;
    [self.player playWithIndex:_index];
    [self reloadViewWithIndex:index];
}

#pragma mark -- 重新布局 --
- (void)reloadViewWithIndex:(NSInteger)index
{
    RadioListModel *model = _modelArray[index];
    [self.secondView setCoverimg:model.coverimg myTitle:model.title];
    [self.thirdView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.webview_url]]];
    for (RadioListModel *temp in _firstView.modelArray) {
        temp.isSelect = NO;
    }
    RadioListModel *model1 = _firstView.modelArray[index];
    model1.isSelect = YES;
    self.firstView.index = index;
    [self.firstView.tableView reloadData];
    [self.delegate changeViewWithImageUrl:model.coverimg title:model.title name:_uname];
}

#pragma mark -- 布局 --
- (void)addSubViews
{
    self.publicView = [[RadioPublicView alloc]initWithFrame:CGRectMake(0, KScreenHeight - 99, KScreenWidth, 99)];
    [self.view addSubview:_publicView];
    self.publicView.line2.backgroundColor = [UIColor lightGrayColor];
    [self.publicView.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight - 100, KScreenWidth, 1)];
    line.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight - 100 - 71)];
    self.scrollView.contentSize = CGSizeMake(KScreenWidth * 4, KScreenHeight - 71 - 100);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.tag = 100;
    self.scrollView.contentOffset = CGPointMake(KScreenWidth, 0);
    [self.view addSubview:_scrollView];
    
    self.playerTypeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playerTypeButton.frame = CGRectMake(KScreenWidth - 60 * 1, 30, 30, 30);
    [self.playerTypeButton setTitle:@"循" forState:UIControlStateNormal];
    [self.playerTypeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_playerTypeButton];
    
//    self.collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.collectButton.frame = CGRectMake(KScreenWidth - 60 * 3, 30, 30, 30);
//    [self.collectButton setTitle:@"藏" forState:UIControlStateNormal];
//    [self.collectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:_collectButton];
//    
//    self.shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.shareButton.frame = CGRectMake(KScreenWidth - 60 * 2, 30, 30, 30);
//    [self.shareButton setTitle:@"享" forState:UIControlStateNormal];
//    [self.shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:_shareButton];
//    
//    self.timingButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.timingButton.frame = CGRectMake(KScreenWidth - 60 * 1, 30, 30, 30);
//    [self.timingButton setTitle:@"时" forState:UIControlStateNormal];
//    [self.timingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:_timingButton];
}

#pragma mark -- 添加界面1 --
- (void)addFirstPlayView
{
    self.firstView = [[RadioPlayOneController alloc]initWithRadioid:_radioid title:_myTitle icon:_icon uname:_uname coverimg:_coverimg desc:_desc count:[_count integerValue] modelArray:_modelArray index:_index];
    self.firstView.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - 100 - 71);
    self.firstView.delegate = self;
    [self.scrollView addSubview:self.firstView.view];
}

#pragma mark -- 代理更新界面 --
- (void)changeSelf:(NSInteger)index
{
    [self.player playWithIndex:index];
    [self reloadViewWithIndex:index];
}

#pragma mark -- 添加界面2 --
- (void)addSecondPlayView
{
    RadioListModel *model = _modelArray[_index];
    self.secondView = [[RadioPlayTwoController alloc]initWithCoverimg:model.coverimg myTitle:model.title];
    self.secondView.view.frame = CGRectMake(KScreenWidth, 0, KScreenWidth, KScreenHeight - 100 - 71);
    [self.scrollView addSubview:self.secondView.view];
}

#pragma mark -- 添加界面3 --
- (void)addThirdPlayView
{
    self.thirdView = [[UIWebView alloc]initWithFrame:CGRectMake(KScreenWidth * 2, 0, KScreenWidth, KScreenHeight - 71)];
    self.thirdView.delegate = self;
    [self.scrollView addSubview:_thirdView];
    RadioListModel *model = _modelArray[_index];
    [self.thirdView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.webview_url]]];
}

#pragma mark -- 添加界面4 --
- (void)addFouthPlayView
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth * 3, (KScreenHeight - 71 - 30) / 2, KScreenWidth, 30)];
    label.text = @"敬请期待";
    label.textAlignment = 1;
    [self.scrollView addSubview:label];
}

#pragma mark -- 控件添加方法 --
- (void)addAction
{
    [self.changeFrameButton addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.publicView.playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.publicView.upButton addTarget:self action:@selector(preMusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.publicView.nextButton addTarget:self action:@selector(nextMusic:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.playerTypeButton addTarget:self action:@selector(playerTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.changeFrameButton setTitle:@"←" forState:UIControlStateNormal];
    [self.typeLabel removeFromSuperview];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.player = [PlayerManager shardManager];
//    NSMutableArray *musicArray = [NSMutableArray array];
//    for (RadioListModel *model in _modelArray) {
//        [musicArray addObject:model.musicUrl];
//    }
//    self.player.musicArray = musicArray;
//    [self.player playWithIndex:_index];
    
    [self addSubViews];
    [self addAction];
    [self addFirstPlayView];
    [self addSecondPlayView];
    [self addThirdPlayView];
    [self addFouthPlayView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [_timer fire];
}

#pragma mark -- 滑动结束时 --
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 100) {
        NSInteger index = scrollView.contentOffset.x / KScreenWidth;
        for (UIView *line in self.publicView.allLine.subviews) {
            line.backgroundColor = [UIColor blackColor];
        }
        UIView *line = self.publicView.allLine.subviews[index];
        line.backgroundColor = [UIColor lightGrayColor];
    }
}

#pragma mark -- 定时器方法 --
- (void)timerAction:(NSTimer *)timer
{
    NSInteger time = [_player currentTime];
    NSInteger maxTime = [_player finishTime];
    self.secondView.maxTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", maxTime / 60, maxTime % 60];
    self.secondView.planSlider.maximumValue = maxTime;
    if (_secondView.planSlider.isHighlighted == YES) {
        return;
    }
    self.secondView.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", time / 60, time % 60];
    self.secondView.planSlider.value = time;
    if (time == maxTime && time != 0) {
        NSInteger index = [self.player musicDidFinish];
        [self reloadViewWithIndex:index];
    }
}

#pragma mark -- 播放模式 --
- (void)playerTypeButtonAction:(UIButton *)button
{
    if (_player.playType == PlayTypeList) {
        self.player.playType = PlayTypeRandom;
        [self.playerTypeButton setTitle:@"随" forState:UIControlStateNormal];
    }
    else if (_player.playType == PlayTypeRandom) {
        self.player.playType = PlayTypeSingle;
        [self.playerTypeButton setTitle:@"单" forState:UIControlStateNormal];
    }
    else if (_player.playType == PlayTypeSingle) {
        self.player.playType = PlayTypeList;
        [self.playerTypeButton setTitle:@"循" forState:UIControlStateNormal];
    }
    
}

#pragma mark -- 播放按钮 --
- (void)playAction:(UIButton *)button
{
    if ([_player isPlaying]) {
        [self.player pause];
        [self.publicView.playButton setBackgroundImage:[UIImage imageNamed:@"play1"] forState:UIControlStateNormal];
    }
    else {
        [self.player continueMusic];
        [self.publicView.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    }
}

#pragma mark -- 上一首按钮 --
- (void)preMusic:(UIButton *)button
{
    NSInteger index = [self.player preMusic];
    [self reloadViewWithIndex:index];
}

#pragma mark -- 下一首按钮 --
- (void)nextMusic:(UIButton *)button
{
    NSInteger index = [self.player nextMusic];
    [self reloadViewWithIndex:index];
}

#pragma mark -- 返回 --
- (void)returnAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
