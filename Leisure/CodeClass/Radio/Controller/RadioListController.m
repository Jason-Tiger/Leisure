//
//  RadioListController.m
//  Leisure
//
//  Created by 若愚 on 16/2/21.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RadioListController.h"
#import "RadioListCell.h"
#import "RadioPlayController.h"



@interface RadioListController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UIImageView *mainImage;
@property(nonatomic, strong)UIButton *authorIconButton;
@property(nonatomic, strong)UILabel *authorNameLabel;
@property(nonatomic, strong)UILabel *detailLabel;
@property(nonatomic, strong)UIImageView *listenerImage;
@property(nonatomic, strong)UILabel *listenerNumLabel;
@property(nonatomic, strong)NSMutableArray *modelArray;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIView *line;
@property(nonatomic, assign)NSInteger footNum;
@property(nonatomic, assign)CGPoint myPoint;

@end

@implementation RadioListController

#pragma mark -- 自定义初始化 --
- (instancetype)initWithRadioid:(NSString *)radioid title:(NSString *)title icon:(NSString *)icon uname:(NSString *)uname coverimg:(NSString *)coverimg desc:(NSString *)desc count:(NSInteger)count
{
    self = [super init];
    if (self) {
        _radioid = radioid;
        _myTitle = title;
        _icon = icon;
        _uname = uname;
        _coverimg = coverimg;
        _desc = desc;
        _count = [NSString stringWithFormat:@"%ld", count];
    }
    return self;
}

#pragma mark -- 控件添加方法 --
- (void)addAction
{
    [self.changeFrameButton addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- 布局 --
- (void)addSubViews
{
    self.mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight / 4 - 1)];
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:_coverimg]];
    [self.view addSubview:_mainImage];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 71 + KScreenHeight / 4 - 1, KScreenWidth, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    self.authorIconButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.authorIconButton.frame = CGRectMake(20, 71 + KScreenHeight / 4 + 20, 30, 30);
    self.authorIconButton.layer.masksToBounds = YES;
    self.authorIconButton.layer.cornerRadius = 15;
    [self.authorIconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_icon] forState:UIControlStateNormal];
    [self.view addSubview:_authorIconButton];
    
    self.authorNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 + 30 + 5, 71 + KScreenHeight / 4 + 20 + 5, KScreenWidth / 3, 20)];
    self.authorNameLabel.font = [UIFont systemFontOfSize:14 * Fit];
    self.authorNameLabel.text = _uname;
    [self.view addSubview:_authorNameLabel];
    
    self.listenerImage = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth - 20 - 50 * Fit - 5 - 20, 71 + KScreenHeight / 4 + 20 + 5, 20, 20)];
    self.listenerImage.image = [UIImage imageNamed:@"listener"];
    [self.view addSubview:_listenerImage];
    
    self.listenerNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth - 50 * Fit - 20, 71 + KScreenHeight / 4 + 20 + 5, 100 * Fit, 20)];
    self.listenerNumLabel.font = [UIFont systemFontOfSize:12 * Fit];
    self.listenerNumLabel.textColor = [UIColor lightGrayColor];
    self.listenerNumLabel.text = _count;
    [self.view addSubview:_listenerNumLabel];
    
    CGRect bounds = [_desc boundingRectWithSize:CGSizeMake(KScreenWidth - 40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17 * Fit] forKey:NSFontAttributeName] context:nil];
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 71 + KScreenHeight / 4 + 20 + 30 + 20, KScreenWidth - 40, bounds.size.height)];
    self.detailLabel.font = [UIFont systemFontOfSize:17 * Fit];
    self.detailLabel.text = _desc;
    self.detailLabel.numberOfLines = 0;
    [self.view addSubview:_detailLabel];
    
    self.line = [[UIView alloc]initWithFrame:CGRectMake(0, 71 + KScreenHeight / 4 + 20 + 30 + 20 + bounds.size.height + 19, KScreenWidth, 1)];
    self.line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_line];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 71 + KScreenHeight / 4 + 20 + 30 + 20 + bounds.size.height + 19 + 1, KScreenWidth, KScreenHeight - (71 + KScreenHeight / 4 + 20 + 30 + 20 + bounds.size.height + 19 + 1)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[RadioListCell class] forCellReuseIdentifier:@"radioListCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark -- 请求数据 --
- (void)getModelArrayWithUrl:(NSString *)url dic:(NSDictionary *)dic requestType:(RequestType)requestType
{
    [RequestManager requestWithUrl:url requestType:requestType parDic:dic finish:^(NSData *data) {
        if (_footNum) {
            [self.modelArray addObjectsFromArray:[RadioListModel modelConfigureData:data]];
        }
        else {
            self.modelArray = [RadioListModel modelConfigureData:data];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            if (_footNum) {
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
    // Do any additional setup after loading the view.
    [self.changeFrameButton setTitle:@"←" forState:UIControlStateNormal];
    self.typeLabel.text = _myTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addAction];
    [self addSubViews];
    [self getModelArrayWithUrl:KTingRadio_detailUrl dic:@{@"radioid":_radioid} requestType:requestTypePost];
    [self addFooter];
    [self addHeader];
}

#pragma mark -- 上拉加载 --
- (void)footerRefreshData:(MJRefreshAutoNormalFooter *)footer
{
    self.footNum ++;
    self.myPoint = _tableView.contentOffset;
    NSDictionary *dic = @{@"radioid" : _radioid, @"start" : @(10 * _footNum)};
    [self getModelArrayWithUrl:KMoreUrl dic:dic requestType:requestTypePost];
    [footer endRefreshing];
}

#pragma mark -- 下拉刷新 --
- (void)headerRefreshData:(MJRefreshNormalHeader *)header
{
    self.footNum = 0;
    [self getModelArrayWithUrl:KTingRadio_detailUrl dic:@{@"radioid":_radioid} requestType:requestTypePost];
    [header endRefreshing];
}

#pragma mark -- 返回 --
- (void)returnAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    RadioListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RadioListModel *model = _modelArray[indexPath.row];
    [cell cellConfigureModel:model];
    return cell;
}

#pragma mark -- 返回cell高度 --
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RadioListCell heightForCellWithModel:nil];
}

#pragma mark -- 点击cell --
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RadioPlayPublicController *oneVc = [[RadioPlayPublicController alloc]initWithRadioid:_radioid title:_myTitle icon:_icon uname:_uname coverimg:_coverimg desc:_desc count:[_count integerValue]];
//    [self presentViewController:oneVc animated:YES completion:nil];
    
    RadioPlayController *oneVc = [RadioPlayController shardRadioPlayController];
    [oneVc setRadioid:_radioid title:_myTitle icon:_icon uname:_uname coverimg:_coverimg desc:_desc count:[_count integerValue] modelArray:_modelArray index:indexPath.row];
    [oneVc openUser];
    [self presentViewController:oneVc animated:YES completion:nil];
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
