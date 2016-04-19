//
//  RegisterController.m
//  Leisure
//
//  Created by 若愚 on 16/2/16.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterView.h"
#import "RegisterModel.h"



@interface RegisterController () <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, strong)RegisterView *myView;
@property(nonatomic, strong)RegisterModel *model;
@property(nonatomic, assign)NSInteger gender;

@end

@implementation RegisterController

#pragma mark -- 布局 --
- (void)addSubViews
{
    self.myView = [[RegisterView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight - 71)];
    [self.view addSubview:_myView];
}

#pragma mark -- 添加方法 --
- (void)addAction
{
    [self.changeFrameButton addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.myView.nameField.delegate = self;
    self.myView.mailField.delegate = self;
    self.myView.passwordField.delegate = self;
    [self.myView.headButton addTarget:self action:@selector(headButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.myView.completeButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.myView.manButton addTarget:self action:@selector(manAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.myView.womanButton addTarget:self action:@selector(womanAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- 键盘的通知 --
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.changeFrameButton setTitle:@"←" forState:UIControlStateNormal];
    self.typeLabel.text = @"注册";
    
    [self addSubViews];
    [self addAction];
}

#pragma mark -- 选择性别 --
- (void)manAction:(UIButton *)button
{
    self.gender = 1;
}
- (void)womanAction:(UIButton *)button
{
    self.gender = 2;
}

#pragma mark -- 注册 --
- (void)registerAction:(UIButton *)button
{
    if (_gender == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择性别" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    NSDictionary *dic = @{@"email":_myView.mailField.text, @"gender":[NSNumber numberWithInteger:_gender], @"passwd":_myView.passwordField.text, @"uname":_myView.nameField.text};
    [RequestManager requestWithUrl:KRegUrl requestType:requestTypePost parDic:dic finish:^(NSData *data) {
        self.model = [RegisterModel modelConfigureData:data];
        NSLog(@"%@", _model);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:(_model.isOk == NO ? _model.msg : @"注册成功") preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (_model.isOk) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark -- 点击头像 --
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
    [self.myView.headButton setBackgroundImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
}

#pragma mark -- 键盘出现 --
- (void)keyBoardShow:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize size = [value CGRectValue].size;
    self.myView.frame = CGRectMake(0, - size.height + 100, KScreenWidth, KScreenHeight - 71);
}

#pragma mark -- 键盘消失 --
- (void)keyBoardHide:(NSNotification *)notification
{
    self.myView.frame = CGRectMake(0, 71, KScreenWidth, KScreenHeight - 71);
}

#pragma mark -- 界面消失时关掉通知 --
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -- 回收键盘 --
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.myView.nameField resignFirstResponder];
    [self.myView.mailField resignFirstResponder];
    [self.myView.passwordField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
