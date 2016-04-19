//
//  RightController.m
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RightController.h"
#import "RootListBaseController.h"
#import "CommunityController.h"
#import "GoodProductsController.h"
#import "RadioController.h"
#import "ReadController.h"

@interface RightController ()

@property(nonatomic, strong)RootListBaseController *baseVc;

@end

@implementation RightController

#pragma mark -- 添加右边界面的初始视图 --
- (void)addSubViews
{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(10, 20, 50, 30);
//    [button setTitle:@"哈哈哈" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(changeFrame:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    self.baseVc = [[RadioController alloc]init];
    self.baseVc.rightVc = self;
    [self.view addSubview:_baseVc.view];
    
}

#pragma mark -- 添加边缘滑动 --
- (void)addEdge
{
    UIScreenEdgePanGestureRecognizer *edge = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgeAction:)];
    edge.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edge];
}

#pragma mark -- 添加轻拍 --
- (void)addTap
{
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    tap.numberOfTapsRequired = 2;
    self.tap.enabled = NO;
    [self.view addGestureRecognizer:_tap];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
//    [self.changeFrameButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubViews];
    [self addEdge];
    [self addTap];
    self.view.layer.shadowOffset = CGSizeMake(-3, 0);
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOpacity = 0.5;
}

#pragma mark -- 轻拍手势 --
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    CGRect newFrame = self.view.frame;
    if (newFrame.origin.x == 0) {
//        newFrame.origin.x += KScreenWidth - 100;
    }
    else {
        newFrame.origin.x = 0;
        self.baseVc.view.userInteractionEnabled = YES;
        self.tap.enabled = NO;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = newFrame;
    } completion:nil];
}

#pragma mark -- 右边缘滑动手势 --
- (void)edgeAction:(UIScreenEdgePanGestureRecognizer *)edge
{
    if (edge.edges == UIRectEdgeLeft) {
        /*
        CGPoint point = [edge translationInView:self.view];
        self.view.transform = CGAffineTransformTranslate(self.view.transform, point.x, self.view.transform.ty);
//        NSLog(@"x == %f", point.x);
        [edge setTranslation:CGPointZero inView:self.view];
         */
        
        CGPoint point = [edge locationInView:self.view.superview];
        CGRect frame = self.view.frame;
        frame.origin.x = point.x;
        self.view.frame = frame;
        
        frame = self.view.frame;
        if (frame.origin.x >= KScreenWidth - 100) {
            frame.origin.x = KScreenWidth - 100;
        }
        else if (frame.origin.x <= 0) {
            frame.origin.x = 0;
        }
        self.view.frame = frame;
    }
    CGRect frame = self.view.frame;
    if (edge.state == UIGestureRecognizerStateEnded) {
        if (frame.origin.x >= (KScreenWidth - 100) / 2) {
            frame.origin.x = KScreenWidth - 100;
            self.baseVc.view.userInteractionEnabled = NO;
            self.tap.enabled = YES;
        }
        else {
            frame.origin.x = 0;
        }
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = frame;
    } completion:nil];
}

#pragma mark -- 跳转界面 --
- (void)changeViewWithIndex:(NSInteger)index
{
//    self.baseVc.view.userInteractionEnabled = YES;
    [self changeFrame:nil];
    NSArray *array = @[@"RadioController", @"ReadController", @"CommunityController", @"GoodProductsController"];
    
    if ([_baseVc isMemberOfClass:NSClassFromString(array[index])]) {
        return;
    }
    
    [_baseVc.view removeFromSuperview];
    
    self.baseVc = [[NSClassFromString(array[index]) alloc] init];
    self.baseVc.typeLabel.text = array[index];
    self.baseVc.rightVc = self;
    [self.view addSubview:_baseVc.view];
    
}

#pragma mark -- 收放抽屉 --
- (void)changeFrame:(UIButton *)button
{
    CGRect newFrame = self.view.frame;
    if (newFrame.origin.x == 0) {
        newFrame.origin.x += KScreenWidth - 100;
        self.baseVc.view.userInteractionEnabled = NO;
        self.tap.enabled = YES;
    }
    else {
        newFrame.origin.x = 0;
        self.baseVc.view.userInteractionEnabled = YES;
        self.tap.enabled = NO;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = newFrame;
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
