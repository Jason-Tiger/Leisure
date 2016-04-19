//
//  ReadCommentController.m
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "ReadCommentController.h"
#import "ReadCommentCell.h"



@interface ReadCommentController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic, strong)UIButton *writeButton;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *modelArray;
@property(nonatomic, strong)UITextField *field;
@property(nonatomic, assign)NSInteger footNum;
@property(nonatomic, assign)CGPoint myPoint;
//@property(nonatomic, strong)NSString *fielfString;

@end

@implementation ReadCommentController

#pragma mark -- 自定义初始化 --
- (instancetype)initWithContentid:(NSString *)contentid
{
    if ([super init]) {
        self.contentid = contentid;
    }
    return self;
}

#pragma mark -- 布局 --
- (void)addSubView
{
    self.writeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.writeButton.frame = CGRectMake(KScreenWidth - 20 - 30, 20 + 10, 30, 30);
    [self.writeButton setTitle:@"✒️" forState:UIControlStateNormal];
    [self.view addSubview:_writeButton];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight - 71) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ReadCommentCell class] forCellReuseIdentifier:@"commentCell"];
    [self.view addSubview:_tableView];
    
    self.field = [[UITextField alloc]initWithFrame:CGRectMake(20, KScreenHeight + 10, KScreenWidth - 40, 30)];
    self.field.delegate = self;
    self.field.placeholder = @"评论";
    self.field.returnKeyType = UIReturnKeyGo;
    self.field.clearButtonMode = UITextFieldViewModeAlways;
    self.field.borderStyle = UITextBorderStyleRoundedRect;
    self.field.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:214 / 255.0 blue:212 / 255.0 alpha:1];
    [self.view addSubview:_field];
}
#pragma mark -- 加一些方法 --
- (void)addAction
{
    [self.changeFrameButton addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.writeButton addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- 加载数据 --
- (void)getModelArray:(NSString *)url requestType:(RequestType)requestType parDic:(NSDictionary *)dic
{
    [RequestManager requestWithUrl:url requestType:requestType parDic:dic finish:^(NSData *data) {
        self.modelArray = [ReadCommentModel modelConfigureData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            if (_footNum - 1) {
                self.tableView.contentOffset = _myPoint;
            }
        });
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark -- 加上拉加载 --
- (void)addFooter
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshData:)];
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.tableView addSubview:footer];
}

#pragma mark -- 加下拉刷新 --
- (void)addHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData:)];
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.tableView addSubview:header];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.footNum = 1;
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.changeFrameButton setTitle:@"←" forState:UIControlStateNormal];
    self.typeLabel.text = @"评论";
    [self addSubView];
    [self addAction];
    [self getModelArray:KCommentGetUrl requestType:requestTypePost parDic:@{@"contentid" : _contentid, @"limit" : @(10 * _footNum)}];
    [self addHeader];
    [self addFooter];
}

#pragma mark -- 上拉加载 --
- (void)footerRefreshData:(MJRefreshAutoNormalFooter *)footer
{
    self.footNum ++;
    self.myPoint = _tableView.contentOffset;
    NSDictionary *dic = @{@"contentid" : _contentid, @"limit" : @(10 * _footNum)};
    [self getModelArray:KCommentGetUrl requestType:requestTypePost parDic:dic];
    [footer endRefreshing];
}

#pragma mark -- 回收键盘 --
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.field resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.myPoint = _tableView.contentOffset;
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"user"];
    LandingModel *model = [LandingDB findUserInfoWithName:name];
    NSDictionary *dic = @{@"auth":model.auth, @"content":_field.text, @"client":@"1", @"contentid":_contentid};
    NSLog(@"%@", dic);
    [RequestManager requestWithUrl:KCommentUrl requestType:requestTypePost parDic:dic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *msg = dic[@"data"][@"msg"];
//        NSNumber *num1 = [dic valueForKey:@"result"];
//        NSInteger isOk = [num1 integerValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSNumber *num1 = [dic valueForKey:@"result"];
                    NSInteger isOk = [num1 integerValue];
                    if (isOk == 1) {
                        [self getModelArray:KCommentGetUrl requestType:requestTypePost parDic:@{@"contentid" : _contentid, @"limit" : @(10 * _footNum)}];
                    }
                }];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
        
        NSLog(@"addDic == %@", dic);
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
    [self.field resignFirstResponder];
    return YES;
}

#pragma mark -- 键盘的通知 --
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -- 键盘出现 --
- (void)keyBoardShow:(NSNotification *)notification
{
    NSDictionary *info = notification.userInfo;
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize size = [value CGRectValue].size;
    self.field.frame = CGRectMake(20, KScreenHeight - size.height - 30 - 10, KScreenWidth - 40, 30);
}

#pragma mark -- 键盘消失 --
- (void)keyBoardHide:(NSNotification *)notification
{
    self.field.frame = CGRectMake(20, KScreenHeight + 10, KScreenWidth - 40, 30);
}

#pragma mark -- 界面消失时关掉通知 --
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -- 删除评论 --
- (void)deleteComment:(UIButton *)button
{
    self.myPoint = _tableView.contentOffset;
    NSInteger tag = button.tag - 1000;
    ReadCommentModel *conModel = _modelArray[tag];
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"user"];
    LandingModel *model = [LandingDB findUserInfoWithName:name];
    NSDictionary *dic = @{@"auth":model.auth, @"client":@"1", @"contentid":_contentid, @"commentid":conModel.contentid};
    NSLog(@"deleteDic == %@", dic);
    [RequestManager requestWithUrl:KDeleteUrl requestType:requestTypePost parDic:dic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *msg = dic[@"data"][@"msg"];
        NSLog(@"%@", dic);
        //        NSNumber *num1 = [dic valueForKey:@"result"];
        //        NSInteger isOk = [num1 integerValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSNumber *num1 = [dic valueForKey:@"result"];
                NSInteger isOk = [num1 integerValue];
                if (isOk == 1) {
                    [self getModelArray:KCommentGetUrl requestType:requestTypePost parDic:@{@"contentid" : _contentid, @"limit" : @(10 * _footNum)}];
                }
                else {
                    
                }
            }];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark -- 评论 --
- (void)commentAction:(UIButton *)button
{
//    self.field.frame = CGRectMake(20, KScreenHeight / 2, KScreenWidth - 40, 30);
    [self.field becomeFirstResponder];
}

#pragma mark -- 下拉刷新 --
- (void)headerRefreshData:(MJRefreshNormalHeader *)header
{
    self.footNum = 1;
    [self getModelArray:KCommentGetUrl requestType:requestTypePost parDic:@{@"contentid" : _contentid, @"limit" : @(10 * _footNum)}];
    [header endRefreshing];
}

#pragma mark -- tableView代理 --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ReadCommentModel *model = _modelArray[indexPath.row];
    [cell cellConfigureModel:model];
    [cell.deleteButton addTarget:self action:@selector(deleteComment:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteButton.tag = 1000 + indexPath.row;
    return cell;
}

#pragma mark -- 返回cell高度 --
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadCommentModel *model = _modelArray[indexPath.row];
    return [ReadCommentCell heightOfRowWithModel:model];
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
