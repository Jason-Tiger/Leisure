//
//  RegisterView.m
//  Leisure
//
//  Created by 若愚 on 16/2/16.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.headButton setBackgroundImage:[UIImage imageNamed:@"86-camera"] forState:UIControlStateNormal];
        self.headButton.backgroundColor = [UIColor lightGrayColor];
        self.headButton.frame = CGRectMake((KScreenWidth - 60) / 2, 100 - 71, 60, 60);
        self.headButton.layer.masksToBounds = YES;
        self.headButton.layer.cornerRadius = 30;
        [self addSubview:_headButton];
        
        NSArray *array = @[@"♂ 男", @"♀ 女"];
        for (int i = 0; i < 2; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithRed:194 / 255.0 green:178 / 255.0 blue:135 / 255.0 alpha:1];
            button.frame = CGRectMake((KScreenWidth - 105 - 50 * 2) / 2 + (50 + 105) * i, KScreenHeight - 71 - 100 - 30 - 30 - 30 - 26 - 30 - 26 - 30 - 30 - 30, 50, 30);
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 5;
            button.tag = 300 + i;
            [self addSubview:button];
        }
        self.manButton = (UIButton *)[self viewWithTag:300];
        self.womanButton = (UIButton *)[self viewWithTag:301];
        
        NSArray *array1 = @[@"昵称：", @"邮箱：", @"密码："];
        for (int i = 0; i < 3; i ++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, KScreenHeight - 71 - 100 - 30 - 30 - 30 - 26 - 30 - 26 - 30 + (30 + 26) * i, 50, 29)];
            label.text = array1[i];
            label.font = [UIFont systemFontOfSize:16 * Fit];
            [self addSubview:label];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(50, KScreenHeight - 71 - 100 - 30 - 30 - 30 - 26 - 30 - 26 - 30 + 29 + (30 + 26) * i, KScreenWidth - 100, 1)];
            line.backgroundColor = [UIColor grayColor];
            [self addSubview:line];
            
            UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(50 + 50, KScreenHeight - 71 - 100 - 30 - 30 - 30 - 26 - 30 - 26 - 30 + (30 + 26) * i, KScreenWidth - 100 - 50, 29)];
            field.font = [UIFont systemFontOfSize:16 * Fit];
            field.tag = 100 + i;
            field.clearButtonMode = UITextFieldViewModeAlways;
            field.returnKeyType = UIReturnKeyDone;
            field.tag = 400 + i;
            [self addSubview:field];
        }
        self.nameField = (UITextField *)[self viewWithTag:400];
        self.mailField = (UITextField *)[self viewWithTag:401];
        self.passwordField = (UITextField *)[self viewWithTag:402];
        self.passwordField.secureTextEntry = YES;
        self.passwordField.clearsOnBeginEditing = YES;
        
        self.completeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.completeButton.frame = CGRectMake(50, KScreenHeight - 71 - 100 - 30, KScreenWidth - 100, 30);
        self.completeButton.backgroundColor = [UIColor colorWithRed:194 / 255.0 green:178 / 255.0 blue:135 / 255.0 alpha:1];
        [self.completeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.completeButton setTitle:@"完成" forState:UIControlStateNormal];
        self.completeButton.layer.masksToBounds = YES;
        self.completeButton.layer.cornerRadius = 5;
        [self addSubview:_completeButton];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, KScreenHeight - 71 - 50, KScreenWidth - 100 - 60 - 10, 20)];
        label.text = @"点击“完成”按钮，代表你已阅读并同意";
        label.font = [UIFont systemFontOfSize:12 * Fit];
        [self addSubview:label];
        
        self.delegateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.delegateButton.frame = CGRectMake(KScreenWidth - 50 - 60, KScreenHeight - 71 - 50, 60, 20);
        [self.delegateButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.delegateButton.titleLabel.font = [UIFont systemFontOfSize:14 * Fit];
        [self.delegateButton setTitle:@"片刻协议" forState:UIControlStateNormal];
        [self addSubview:_delegateButton];
        
    }
    return self;
}

@end
