//
//  RootController.m
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//
#import "LandingView.h"
#import "RootController.h"
#import "RightController.h"
#import "RootControllerCell.h"
#import "LandingController.h"
#import "RegisterController.h"
#import "RadioPlayController.h"

@interface RootController ()<UITableViewDataSource, UITableViewDelegate, RadioPlayControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, strong)RightController *rightVc;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *titleArray;
@property(nonatomic, strong)NSArray *imageArray;
@property(nonatomic, strong)UIImageView *headImageView;

@property(nonatomic, strong)UIButton *headButton;
@property(nonatomic, strong)UIButton *landingButton;
@property(nonatomic, strong)UIButton *registerButton;
@property(nonatomic, strong)UIButton *downloadButton;
@property(nonatomic, strong)UIButton *collectButton;
@property(nonatomic, strong)UIImageView *musicImage;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UIButton *stopButton;
@property(nonatomic, strong)UILabel *sexLabel;
@property(nonatomic, strong)LandingView *landingView;

//_btnHead.layer.masksToBounds = YES; _btnHead.layer.cornerRadius = 按钮宽的一半;
@end

@implementation RootController

#pragma mark -- tableView之外的布局 --
- (void)addSubviews
{
    //NSString *iconURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"iconURL"];
    
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 40, 50, 50)];
    //[self.headImageView sd_setImageWithURL:[NSURL URLWithString:iconURL]];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 25;

    [self.view addSubview:_headImageView];
    
    
    self.landingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.landingButton.frame = CGRectMake(80, 50, 40, 30);
    [self.landingButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.landingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.landingButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_landingButton];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(124, 55, 2, 20)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registerButton.frame = CGRectMake(124 + 2 + 4, 50, 40, 30);
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_registerButton];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40 + 50 + 20, KScreenWidth - 100, 1)];
    line1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line1];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 40 + 50 + 20 + 1 + 30, KScreenWidth - 100, 1)];
    line2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line2];
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake((KScreenWidth - 100) / 2, 40 + 50 + 20 + 1, 1, 30)];
    line3.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line3];
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight - 60, KScreenWidth - 100, 1)];
    line4.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line4];
    
    self.downloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.downloadButton.frame = CGRectMake(0, 40 + 50 + 20 + 1, (KScreenWidth - 100) / 2, 30);
    [self.downloadButton setTitle:@"↓" forState:UIControlStateNormal];
    [self.downloadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_downloadButton];
    
    self.collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.collectButton.frame = CGRectMake((KScreenWidth - 100) / 2 + 1, 40 + 50 + 20 + 1, (KScreenWidth - 100) / 2 - 1, 30);
    [self.collectButton setTitle:@"❤" forState:UIControlStateNormal];
    [self.collectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_collectButton];
    
    self.musicImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, KScreenHeight - 60 + 1 + 10, 40, 40)];
//    [self.musicImage setImage:[UIImage imageNamed:@"eye"]];
    [self.view addSubview:_musicImage];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 + 40 + 10, KScreenHeight - 60 + 1 + 10 + 2, 160 * Fit, 16)];
//    self.titleLabel.text = @"无";
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_titleLabel];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 + 40 + 10, KScreenHeight - 60 + 1 + 10 + 20 + 2, 160 * Fit, 16)];
//    self.nameLabel.text = @"无";
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_nameLabel];
    
    self.stopButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.stopButton.frame = CGRectMake((KScreenWidth - 100) - 20 - 10, KScreenHeight - 60 + 1 + 20, 20, 20);
    [self.stopButton setTitle:@"▶" forState:UIControlStateNormal];
    [self.stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.stopButton.hidden = YES;
    [self.view addSubview:_stopButton];
    
    self.sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(124 + 2 + 4 + 40 + 10, 57, 12, 12)];
    self.sexLabel.font = [UIFont systemFontOfSize:10];
    self.sexLabel.text = @"♂";
    self.sexLabel.backgroundColor = [UIColor colorWithRed:177 / 255.0 green:237 / 255.0 blue:177 / 255.0 alpha:0.7];
    self.sexLabel.layer.masksToBounds = YES;
    self.sexLabel.layer.cornerRadius = 6;
    self.sexLabel.textAlignment = 1;
    [self.view addSubview:_sexLabel];
}

#pragma mark -- 渐变色 --
- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = CGRectMake(0, 0, KScreenWidth,KScreenHeight);
    newShadow.frame = newShadowFrame;
    //添加渐变的颜色组合（颜色透明度的改变）
    UIColor *color = [UIColor colorWithRed:214 / 255.0 green:197 / 255.0 blue:119 / 255.0 alpha:1];
    newShadow.colors = [NSArray arrayWithObjects:
                        (id)[[color colorWithAlphaComponent:0.7] CGColor] ,
                        (id)[[color colorWithAlphaComponent:0.6] CGColor],
                        (id)[[color colorWithAlphaComponent:0.5] CGColor],
                        (id)[[color colorWithAlphaComponent:0.4] CGColor],
                        (id)[[color colorWithAlphaComponent:0.3] CGColor],
                        (id)[[color colorWithAlphaComponent:0.2] CGColor],
                        nil];
    return newShadow;
}

#pragma mark -- 获取cell代表界面的名称和图片 --
- (void)getTitleArray
{
    self.titleArray = @[@"电台", @"阅读", @"社区", @"良品"];
    self.imageArray = @[@"listen", @"read", @"comment", @"good"];
}

#pragma mark -- 加个全屏的view来渐变 --
- (void)addView
{
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    myView.backgroundColor = [UIColor whiteColor];
    [myView.layer addSublayer:[self shadowAsInverse]];
    [self.view addSubview:myView];
}

#pragma mark -- 创建tableview --
- (void)getTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 180, KScreenWidth - 100, KScreenHeight - 180 - 60) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[RootControllerCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = [UIColor colorWithRed:231 / 255.0 green:233 / 255.0 blue:195 / 255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}

#pragma mark -- 添加右边视图 --
- (void)addRightVc
{
    self.rightVc = [[RightController alloc]init];
    self.rightVc.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [self addChildViewController:_rightVc];
    [self.view addSubview:_rightVc.view];
}

#pragma mark -- 给控件添加方法 --
- (void)addAction
{
    [self.landingButton addTarget:self action:@selector(landingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.stopButton addTarget:self action:@selector(goToPlayView:) forControlEvents:UIControlEventTouchUpInside];
    self.headImageView.userInteractionEnabled = YES;
    //[self.headImageView addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addView];
    [self getTitleArray];
    [self getTableView];
    [self addSubviews];
    [self addRightVc];
    [self addAction];
    [RadioPlayController shardRadioPlayController].delegate = self;
//    [self.view.layer addSublayer:[self shadowAsInverse]];
}

#pragma mark -- 换头像 --
- (void)headButtonAction:(UIButton *)button
{
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择头像" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            picker.allowsEditing = YES;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
        
    }];
    [sheet addAction:cancelAction];
    [sheet addAction:photoAction];
    [sheet addAction:cameraAction];
    [self presentViewController:sheet animated:YES completion:nil];
}

#pragma mark -- 执行完拍摄调用的方法 --
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.headButton setBackgroundImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
}

#pragma mark -- 播放界面的代理方法 --
- (void)changeViewWithImageUrl:(NSString *)imageUrl title:(NSString *)title name:(NSString *)name
{
    if ([[PlayerManager shardManager] musicArray]) {
        [self. musicImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        self.titleLabel.text = title;
        self.nameLabel.text = name;
        self.stopButton.hidden = NO;
    }
}

#pragma mark -- 去播放界面 --
- (void)goToPlayView:(UIButton *)button
{
    if ([[PlayerManager shardManager] musicArray]) {
//        [self.rightVc changeFrame:nil];
//        self.rightVc.view.userInteractionEnabled = YES;
        RadioPlayController *player = [RadioPlayController shardRadioPlayController];
        [player openUser];
        [self presentViewController:player animated:YES completion:nil];
    }
}

#pragma mark -- 登陆注册跳转 --
- (void)landingAction:(UIButton *)button
{
    BOOL isLanding = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLanding"];
    if (!isLanding) {
        LandingController *landVc = [[LandingController alloc]init];
        [self presentViewController:landVc animated:YES completion:nil];
    }
//    else {
//        self.landingButton.userInteractionEnabled = NO;
//        [self.landingButton setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"user"] forState:UIControlStateNormal];
//    }
    
}
- (void)registerAction:(UIButton *)button
{
    BOOL isLanding = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLanding"];
    if (!isLanding) {
        RegisterController *regVc = [[RegisterController alloc]init];
        [self presentViewController:regVc animated:YES completion:nil];
    }
    else {
        self.landingButton.userInteractionEnabled = YES;
        self.landingButton.titleLabel.font = [UIFont systemFontOfSize:17 * Fit];
        self.registerButton.titleLabel.font = [UIFont systemFontOfSize:17 * Fit];
        [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [self.landingButton setTitle:@"登陆" forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLanding"];
    }
}

#pragma mark -- 界面将要出现 --
- (void)viewWillAppear:(BOOL)animated
{
    BOOL isLanding = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLanding"];
    if (isLanding) {
        self.landingButton.userInteractionEnabled = NO;
        self.landingButton.titleLabel.font = [UIFont systemFontOfSize:12 * Fit];
        self.registerButton.titleLabel.font = [UIFont systemFontOfSize:12 * Fit];
        [self.landingButton setTitle:[[NSUserDefaults standardUserDefaults] stringForKey:@"user"] forState:UIControlStateNormal];
       
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] stringForKey:@"iconURL"]]];
        [self.registerButton setTitle:@"注销" forState:UIControlStateNormal];
    }
    else {
        self.landingButton.userInteractionEnabled = YES;
        self.landingButton.titleLabel.font = [UIFont systemFontOfSize:17 * Fit];
        self.registerButton.titleLabel.font = [UIFont systemFontOfSize:17 * Fit];
        [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [self.landingButton setTitle:@"登陆" forState:UIControlStateNormal];
    }
    
//    if ([[PlayerManager shardManager] musicArray]) {
//        if (!_titleLabel.text) {
//            RadioPlayController *play = [RadioPlayController shardRadioPlayController];
//            [self. musicImage sd_setImageWithURL:[NSURL URLWithString:play.secondView.coverimg]];
//            self.titleLabel.text = play.secondView.myTitle;
//            self.nameLabel.text = play.firstView.uname;
//        }
//    }
}

#pragma mark -- tableView代理 --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RootControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.typeLabel.text = _titleArray[indexPath.row];
    cell.typeImage.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.backgroundColor = [UIColor colorWithRed:231 / 255.0 green:233 / 255.0 blue:195 / 255.0 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.rightVc changeViewWithIndex:indexPath.row];
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
