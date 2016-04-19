//
//  WheelView.m
//  WheelPhoto
//
//  Created by lanou on 16/3/17.
//  Copyright © 2016年 yollet. All rights reserved.
//

#import "WheelView.h"

@implementation WheelView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSMutableArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isGo = YES;
        self.imageArr = imageArray;
        self.myFrame = frame;
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.contentSize = CGSizeMake((imageArray.count + 2) * frame.size.width, frame.size.height);
        for (int i = 1; i < imageArray.count + 1; i ++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
            imageView.image = _imageArr[i - 1];
            [self.scrollView addSubview:imageView];
        }
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.contentOffset = CGPointMake(frame.size.width, 0);
        UIImageView *firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        firstImage.image = [_imageArr lastObject];
        [self.scrollView addSubview:firstImage];
        UIImageView *lastImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width * (_imageArr.count + 1), 0, frame.size.width, frame.size.height)];
        lastImage.image = [_imageArr firstObject];
        [self.scrollView addSubview:lastImage];
        self.scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(3 / 5.0 * frame.size.width, 0.75 * frame.size.height, 2 / 5.0 * frame.size.width, 0.25 * frame.size.height)];
        self.page.numberOfPages = _imageArr.count;
        self.page.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.page.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.page.userInteractionEnabled = NO;
        [self addSubview:_page];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
//        [self.timer fire];
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x / _myFrame.size.width == 0) {
        self.scrollView.contentOffset = CGPointMake(_myFrame.size.width * _imageArr.count, 0);
    }
    if (scrollView.contentOffset.x / _myFrame.size.width == _imageArr.count + 1) {
        self.scrollView.contentOffset = CGPointMake(_myFrame.size.width, 0);
    }
    NSLog(@"%.0f", scrollView.contentOffset.x / _myFrame.size.width);
    self.page.currentPage = scrollView.contentOffset.x / _myFrame.size.width - 1;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(goGoGo) object:nil];
    [self performSelector:@selector(goGoGo) withObject:nil afterDelay:3];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(goGoGo) object:nil];
    self.isGo = NO;
}

- (void)goGoGo
{
    self.isGo = YES;
}

- (void)timerAction:(NSTimer *)timer
{
    if (self.isGo) {
        NSInteger count = _scrollView.contentOffset.x / _myFrame.size.width;
        [UIView animateWithDuration:0.5 animations:^{
            if (count > 0 && count < _imageArr.count + 1) {
                self.scrollView.contentOffset = CGPointMake(_myFrame.size.width * (count + 1), 0);
                if (_scrollView.contentOffset.x / _myFrame.size.width > 0 && _scrollView.contentOffset.x / _myFrame.size.width < _imageArr.count + 1) {
                    self.page.currentPage = _scrollView.contentOffset.x / _myFrame.size.width - 1;
                }
                else if (_scrollView.contentOffset.x / _myFrame.size.width == 0) {
                    self.page.currentPage = 3;
                }
                else if (_scrollView.contentOffset.x / _myFrame.size.width == _imageArr.count + 1) {
                    self.page.currentPage = 0;
                }
                
            }
        }];
        if (count == 0) {
            self.scrollView.contentOffset = CGPointMake(_myFrame.size.width * _imageArr.count, 0);
            [self timerAction:timer];
        }
        else if (count == _imageArr.count + 1) {
            self.scrollView.contentOffset = CGPointMake(_myFrame.size.width, 0);
            [self timerAction:timer];
        }
    }
}

- (void)changeImageWithImageArray:(NSMutableArray *)imageArray
{
    for (int i = 0; i < imageArray.count; i ++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.image = imageArray[i];
    }
    UIImageView *firstImage = self.scrollView.subviews[imageArray.count];
    firstImage.image = [imageArray lastObject];
    UIImageView *lastImage = self.scrollView.subviews[imageArray.count + 1];
    lastImage.image = [imageArray firstObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
