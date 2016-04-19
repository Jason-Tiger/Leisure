//
//  LandingView.m
//  Leisure
//
//  Created by 若愚 on 16/2/16.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//
#import "GBLoginManager.h"
#import "LandingController.h"
#import "LandingView.h"
@interface LandingView()

@property(nonatomic, strong)LandingController *landVc;


@end
@implementation LandingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth - 60) / 2, 100 - 71, 60, 60)];
        self.headImage.layer.masksToBounds = YES;
        self.headImage.layer.cornerRadius = 30;
        //self.headImage.image = [UIImage imageNamed:@"heiZi11"];
        [self addSubview:_headImage];
        
        NSArray *array = @[@"邮箱：", @"密码："];
        for (int i = 0; i < 2; i ++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, KScreenHeight - 100 - 20 - 56 - 30 - 25 - 30 - 56 - 30 + (30 + 26) * i - 71, 50, 29)];
            label.text = array[i];
            label.font = [UIFont systemFontOfSize:16 * Fit];
            [self addSubview:label];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(50, KScreenHeight - 100 - 20 - 56 - 30 - 25 - 30 - 56 - 30 + (30 + 26) * i + 29 - 71, KScreenWidth - 100, 1)];
            line.backgroundColor = [UIColor grayColor];
            [self addSubview:line];
            
            UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(50 + 50, KScreenHeight - 100 - 20 - 56 - 30 - 25 - 30 - 56 - 30 + (30 + 26) * i - 71, KScreenWidth - 100 - 50, 29)];
            field.font = [UIFont systemFontOfSize:16 * Fit];
            field.tag = 100 + i;
            field.clearButtonMode = UITextFieldViewModeAlways;
            field.returnKeyType = UIReturnKeyDone;
            [self addSubview:field];
        }
        self.mailField = (UITextField *)[self viewWithTag:100];
        self.passwordField = (UITextField *)[self viewWithTag:101];
        
        self.passwordField.secureTextEntry = YES;
        self.passwordField.clearsOnBeginEditing = YES;
        
        self.landingButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.landingButton.frame = CGRectMake(50, KScreenHeight - 100 - 20 - 56 - 30 - 71, KScreenWidth - 100, 30);
        [self.landingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.landingButton.backgroundColor = [UIColor colorWithRed:194 / 255.0 green:178 / 255.0 blue:135 / 255.0 alpha:1];
        [self.landingButton setTitle:@"登陆" forState:UIControlStateNormal];
        self.landingButton.layer.masksToBounds = YES;
        self.landingButton.layer.cornerRadius = 5;
        [self addSubview:_landingButton];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(20, KScreenHeight - 100 - 10 - 71, (KScreenWidth - 40) / 3, 1)];
        line1.backgroundColor = [UIColor grayColor];
        [self addSubview:line1];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(20 + (KScreenWidth - 40) / 3 * 2, KScreenHeight - 100 - 10 - 71, (KScreenWidth - 40) / 3, 1)];
        line2.backgroundColor = [UIColor grayColor];
        [self addSubview:line2];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20 + (KScreenWidth - 40) / 3 * 1, KScreenHeight - 100 - 20 - 71, (KScreenWidth - 40) / 3, 20)];
        label.textAlignment = 1;
        label.text = @"合作伙伴登陆";
        label.font = [UIFont systemFontOfSize:14 * Fit];
        [self addSubview:label];
        
        NSArray *array1 = @[@"新浪",@"微信",  @"QQ", @"人人"];
        for (int i = 0; i < 4; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(((KScreenWidth - 80 - 40 * 4) / 3 + 40) * i + 40 , KScreenHeight - 30 - 40 - 71, 40, 40);
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 20;
            button.backgroundColor = [UIColor colorWithRed:8 / 255.0 green:247 / 255.0 blue:198 / 255.0 alpha:0.7];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitle:array1[i] forState:UIControlStateNormal];
            button.tag = 200 + i;
            [self addSubview:button];
        }
        self.sinaButton = (UIButton *)[self viewWithTag:200];
        self.weiXinButton = (UIButton *)[self viewWithTag:201];
        self.qqButton = (UIButton *)[self viewWithTag:202];
        self.renRenButton = (UIButton *)[self viewWithTag:205];
        
        /*[self.weiXinButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.renRenButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.sinaButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.qqButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];*/
        
    }
    return self;
}

/*- (void)buttonclick:(UIButton*)button{
    if(button.tag==200){
        
        //新浪
        [GBLoginManager SinaSSO:_landVc AndGetUserinfoBlock:^(NSDictionary *snsAccount) {
            NSLog(@"===========%@",snsAccount);
            _userdic = snsAccount;
            
        }];
        
        
    }else if(button.tag==201){
        
        //微信
        
        [GBLoginManager WeiChatSSO:_landVc AndGetUserinfoBlock:^(NSDictionary *snsAccount) {
            NSLog(@"===========%@",snsAccount);
            _userdic = snsAccount;
        }];
        
        
        
    }else if (button.tag==202){
        //qq
        
        [GBLoginManager QQSSOWithDelegate:_landVc AndGetUserinfoBlock:^(NSDictionary *snsAccount) {
            NSLog(@"qq===========%@",snsAccount);
            _userdic = snsAccount;
        }];
        
        
    }else if(button.tag==103){
        
        //qqzone
        
        [GBLoginManager QQZoneSSO:_landVc AndGetUserinfoBlock:^(NSDictionary *snsAccount) {
            NSLog(@"===========%@",snsAccount);
            _userdic = snsAccount;
        
        }];
        
    }else if (button.tag==104){
        //腾讯微博
        
        [GBLoginManager TencentWeiboSSO:_landVc AndGetUserinfoBlock:^(NSDictionary *snsAccount) {
            NSLog(@"===========%@",snsAccount);
            _userdic = snsAccount;
            
            
        }];
        
        
        
    }else if (button.tag==205){
        //人人网
        [GBLoginManager RenRenSSO:_landVc AndGetUserinfoBlock:^(NSDictionary *snsAccount) {
            NSLog(@"===========%@",snsAccount[@"userName"]);
            _userdic = snsAccount;            
        }];
        
    }
    
    else  if(button.tag==106){
        
        // 解除授权
        
        [GBLoginManager cancelLogin];
        
        
    }
    //[self landingAction];
    
}*/

@end
