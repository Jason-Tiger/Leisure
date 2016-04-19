//
//  RootListBaseController.m
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//
#import "RootListBaseController.h"

@interface RootListBaseController ()

@end

@implementation RootListBaseController

#pragma mark -- 布局 --
- (void)rootListBaseControllerSetViews
{
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KScreenWidth, 50)];
    [self.view addSubview:_topView];
    
    self.changeFrameButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.changeFrameButton.frame = CGRectMake(10, 10, 30, 30);
    [self.changeFrameButton setTitle:@"三" forState:UIControlStateNormal];
    [self.changeFrameButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.changeFrameButton addTarget:self action:@selector(changeFrameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:_changeFrameButton];
    
//    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 50)];
//    line1.backgroundColor = [UIColor grayColor];
//    [self.topView addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(50, 0, 1, 50)];
    line2.backgroundColor = [UIColor grayColor];
    [self.topView addSubview:line2];
    
//    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(KScreenWidth, 0, 1, 50)];
//    line3.backgroundColor = [UIColor grayColor];
//    [self.topView addSubview:line3];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 1)];
    line4.backgroundColor = [UIColor grayColor];
    [self.topView addSubview:line4];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, KScreenWidth, 1)];
    line5.backgroundColor = [UIColor grayColor];
    [self.topView addSubview:line5];
    
    self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 200 * Fit, 30)];
    self.typeLabel.text = @"类型";
    self.typeLabel.textColor = [UIColor grayColor];
    [self.topView addSubview:_typeLabel];
}

#pragma mark -- 添加右扫(未调用) --
- (void)addSwipe
{
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipeAction:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self rootListBaseControllerSetViews];
    
    
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(10, 110, 30, 30);
//    [button setTitle:@"ss" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(aa) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
}

//- (void)aa
//{
//    NSLog(@"sss");
//}

#pragma mark -- 右扫打开抽屉(未调用) --
- (void)rightSwipeAction:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        CGRect newFrame = self.rightVc.view.frame;
        if (newFrame.origin.x == 0) {
            newFrame.origin.x += KScreenWidth - 100;
        }
        else {
//            newFrame.origin.x = 0;
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.rightVc.view.frame = newFrame;
        } completion:nil];
    }
}

#pragma mark -- 触摸空白收起抽屉 --
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    CGRect newFrame = self.rightVc.view.frame;
//    if (newFrame.origin.x == 0) {
////        newFrame.origin.x += KScreenWidth - 100;
//    }
//    else {
//        newFrame.origin.x = 0;
//    }
//    [UIView animateWithDuration:0.5 animations:^{
//        self.rightVc.view.frame = newFrame;
//    } completion:nil];
}

#pragma mark -- 点击左上按钮收放抽屉 --
- (void)changeFrameAction:(UIButton *)button
{
    CGRect newFrame = self.rightVc.view.frame;
    if (newFrame.origin.x == 0) {
        newFrame.origin.x += KScreenWidth - 100;
        self.view.userInteractionEnabled = NO;
        self.rightVc.tap.enabled = YES;
    }
    else {
        newFrame.origin.x = 0;
        self.view.userInteractionEnabled = YES;
        self.rightVc.tap.enabled = NO;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.rightVc.view.frame = newFrame;
    } completion:nil];
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
