//
//  WheelView.h
//  WheelPhoto
//
//  Created by lanou on 16/3/17.
//  Copyright © 2016年 yollet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WheelView : UIView <UIScrollViewDelegate>

@property(nonatomic, strong)NSArray *imageArr;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, assign)CGRect myFrame;
@property(nonatomic, strong)UIPageControl *page;
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, assign)BOOL isGo;

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSMutableArray *)imageArray;

- (void)changeImageWithImageArray:(NSMutableArray *)imageArray;

@end
