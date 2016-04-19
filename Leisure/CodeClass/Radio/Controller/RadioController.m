//
//  RadioController.m
//  Leisure
//
//  Created by 若愚 on 16/2/10.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "RadioController.h"
#import "RadioCell.h"
#import "RadioModel.h"
#import "RadioListController.h"


@interface RadioController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)WheelView *scrollView;
@property(nonatomic, strong)UIPageControl *page;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *modelArray;
@property(nonatomic, strong)NSMutableArray *imageArray;
@property(nonatomic, strong)NSMutableArray *imageUrlArray;
@property(nonatomic, assign)NSInteger footNum;
@property(nonatomic, strong)NSArray *firstModelArr;
@property(nonatomic, assign)CGPoint myPoint;
@property(nonatomic, strong)FMDatabase *db;

@end

@implementation RadioController

- (void)dealloc
{
    [_scrollView.timer invalidate];
    _scrollView.timer = nil;
}

#pragma mark -- 布局 --
- (void)addSubViews
{
//    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight * 0.3)];
//    self.scrollView.backgroundColor = [UIColor colorWithRed:150 / 255.0 green:150 / 255.0 blue:250 / 255.0 alpha:1];
//    //    self.scrollView.contentSize =
//    [self.view addSubview:_scrollView];
    
//    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(KScreenWidth - 100 - 10, KScreenHeight * 0.3 + 71 - 10 - 20, 100, 20)];
//    self.page.backgroundColor = [UIColor clearColor];
//    self.page.numberOfPages = 5;
//    self.page.currentPageIndicatorTintColor = [UIColor blackColor];
//    self.page.currentPageIndicatorTintColor = [UIColor lightGrayColor];
//    [self.view addSubview:_page];
    
    UILabel *allRadiosLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 71 + KScreenHeight * 0.3 + 20, KScreenWidth / 3, 20)];
    allRadiosLabel.text = @"全部电台·All Radios";
    allRadiosLabel.textColor = [UIColor lightGrayColor];
    allRadiosLabel.font = [UIFont systemFontOfSize:14 * Fit];
    [self.view addSubview:allRadiosLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10 + KScreenWidth / 3 + 5, 71 + KScreenHeight * 0.3 + 30, KScreenWidth - KScreenWidth / 3 - 10 - 5, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 71 + KScreenHeight * 0.3 + 20 + 20 + 1.5, KScreenWidth, KScreenHeight - 71 - KScreenHeight * 0.3 - 20 - 20 - 1.5) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[RadioCell class] forCellReuseIdentifier:@"radioCell"];
    [self.view addSubview:_tableView];
}

#pragma mark -- 获得轮播图数据 --
- (void)getImageArray:(NSString *)url requestType:(RequestType)requestType parDic:(NSDictionary *)dic
{
    [RequestManager requestWithUrl:url requestType:requestType parDic:dic finish:^(NSData *data) {
        self.imageUrlArray = [RadioModel getImageArray:data];
        [self deleteData:NO];
        [self storeData:NO];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        self.imageArray = [NSMutableArray array];
        for (NSString *imageStr in self.imageUrlArray) {
            [manager downloadImageWithURL:[NSURL URLWithString:imageStr] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                [self.imageArray addObject:image];
                if (_imageArray.count == _imageUrlArray.count) {
                    if (_imageArray) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (!_scrollView) {
                                self.scrollView = [[WheelView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight * 0.3) imageArray:_imageArray];
                                [self.view addSubview:_scrollView];
                            }
                            else {
                                [self.scrollView changeImageWithImageArray:_imageArray];
                            }
                            
                        });
                        
                    }
                }
            }];
        }
        
    } failure:^(NSError *error) {
        if (![NetWorkState reachability]) {
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            self.imageArray = [NSMutableArray array];
            for (NSString *imageStr in self.imageUrlArray) {
                [manager downloadImageWithURL:[NSURL URLWithString:imageStr] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    [self.imageArray addObject:image];
                    if (_imageArray) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (!_scrollView) {
                                self.scrollView = [[WheelView alloc]initWithFrame:CGRectMake(0, 71, KScreenWidth, KScreenHeight * 0.3) imageArray:_imageArray];
                                [self.view addSubview:_scrollView];
                           }
                       });
                    }
               }];
            }
        }
        else {
             NSLog(@"请求失败");
        }
    }];
}

#pragma mark -- 打开数据库 --
- (void)openDB
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"StoreData.db"];
    self.db = [FMDatabase databaseWithPath:path];
    NSLog(@"StoreData.path == %@", path);
    if (![_db open]) {
        NSLog(@"打不开StoreData");
    }
    //    @property(nonatomic, assign)NSInteger count;
    //    @property(nonatomic, strong)NSString *coverimg;
    //    @property(nonatomic, strong)NSString *desc;
    //    @property(nonatomic, assign)BOOL isnew;
    //    @property(nonatomic, strong)NSString *title;
    //    @property(nonatomic, strong)NSString *uname;
    //    @property(nonatomic, strong)NSString *radioid;
    //    @property(nonatomic, strong)NSString *icon;
    [self.db executeUpdate:@"CREATE TABLE RadioFirst (count integer, coverimg text, desc text, isnew integer, title text, uname text, radioid text, icon text)"];
    [self.db executeUpdate:@"CREATE TABLE RadioImage (image text)"];
}

#pragma mark -- 数据储存 --
- (void)storeData:(BOOL)isModelArray
{
    if (isModelArray) {
        if (_modelArray) {
            for (RadioModel *model in _modelArray) {
                NSInteger i;
                if (model.isnew) {
                    i = 1;
                }
                else {
                    i = 0;
                }
                [self.db executeUpdate:@"INSERT INTO RadioFirst (count, coverimg, desc, isnew, title, uname, radioid, icon) VALUES (?,?,?,?,?,?,?,?)", @(model.count), model.coverimg, model.desc, @(i), model.title, model.uname, model.radioid, model.icon];
            }
        }
    }
    else {
        if (_imageUrlArray) {
            for (NSString *imageUrl in _imageUrlArray) {
                [self.db executeUpdate:@"INSERT INTO RadioImage (image) VALUES (?)", imageUrl];
            }
        }
        
    }
}

#pragma mark -- 找全部数据 --
- (void)searchAllData:(BOOL)isModelArray
{
    if (isModelArray) {
        FMResultSet *rs = [_db executeQuery:@"SELECT * FROM RadioFirst"];
        self.modelArray = [NSMutableArray array];
        while ([rs next]) {
            RadioModel *model = [[RadioModel alloc]init];
            model.count = [rs intForColumn:@"count"];
            model.coverimg = [rs stringForColumn:@"coverimg"];
            model.desc = [rs stringForColumn:@"desc"];
            model.isnew = [rs intForColumn:@"isnew"];
            model.title = [rs stringForColumn:@"title"];
            model.uname = [rs stringForColumn:@"uname"];
            model.radioid = [rs stringForColumn:@"radioid"];
            model.icon = [rs stringForColumn:@"icon"];
            [self.modelArray addObject:model];
        }
    }
    else {
        FMResultSet *rs = [_db executeQuery:@"SELECT * FROM RadioImage"];
        self.imageUrlArray = [NSMutableArray array];
        while ([rs next]) {
            NSString *url = [rs stringForColumn:@"image"];
            [self.imageUrlArray addObject:url];
        }
    }
    
}

#pragma mark -- 删除本地数据 --
- (void)deleteData:(BOOL)isModelArray
{
    if (isModelArray) {
        [self.db executeUpdate:@"DELETE FROM RadioFirst"];
    }
    else {
        [self.db executeUpdate:@"DELETE FROM RadioImage"];
    }
}

#pragma mark -- 获得数据 --
- (void)getModelArray:(NSString *)url requestType:(RequestType)requestType parDic:(NSDictionary *)dic
{
    [RequestManager requestWithUrl:url requestType:requestType parDic:dic finish:^(NSData *data) {
        self.modelArray = [RadioModel modelConfigureData:data];
        if (!_footNum) {
            self.firstModelArr = _modelArray;
        }
        else {
            self.modelArray = (NSMutableArray *)[_firstModelArr arrayByAddingObjectsFromArray:_modelArray];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self deleteData:YES];
            [self storeData:YES];
            [self.tableView reloadData];
            if ([url isEqualToString:KFootUrl]) {
                self.tableView.contentOffset = _myPoint;
            }
        });
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark -- 加下拉刷新 --
- (void)addHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData:)];
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.tableView addSubview:header];
}

#pragma mark -- 加上拉加载 --
- (void)addFooter
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshData:)];
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.tableView addSubview:footer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.footNum = 0;
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.typeLabel.text = @"电台";
    
    [self openDB];
    [self addSubViews];
    if ([NetWorkState reachability]) {
        [self getModelArray:KTingRadioUrl requestType:requestTypePost parDic:nil];
        [self getImageArray:KTingRadioUrl requestType:requestTypePost parDic:nil];
    }
    else {
        [self searchAllData:YES];
        [self searchAllData:NO];
        [self getImageArray:KTingRadioUrl requestType:requestTypePost parDic:nil];
    }
    [self addHeader];
    [self addFooter];
    
}

#pragma mark -- 上拉加载 --
- (void)footerRefreshData:(MJRefreshAutoNormalFooter *)footer
{
    self.footNum ++;
    self.myPoint = _tableView.contentOffset;
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"user"];
    LandingModel *model = [LandingDB findUserInfoWithName:name];
    if ([NetWorkState reachability]) {
        if (model.auth) {
            NSLog(@"%@", model.auth);
            NSDictionary *dic = @{@"limit":@(10 * _footNum), @"auth":model.auth};
            [self getModelArray:KFootUrl requestType:requestTypePost parDic:dic];
        }
    }
    [footer endRefreshing];
}

#pragma mark -- 下拉刷新 --
- (void)headerRefreshData:(MJRefreshNormalHeader *)header
{
    self.footNum = 0;
    if ([NetWorkState reachability]) {
        [self getModelArray:KTingRadioUrl requestType:requestTypePost parDic:nil];
        [self getImageArray:KTingRadioUrl requestType:requestTypePost parDic:nil];
    }
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
    RadioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor orangeColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RadioModel *model = _modelArray[indexPath.row];
    [cell cellConfigureModel:model];
    return cell;
}

#pragma mark -- 点击cell --
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioModel *model = _modelArray[indexPath.row];
    RadioListController *listVc = [[RadioListController alloc] initWithRadioid:model.radioid title:model.title icon:model.icon uname:model.uname coverimg:model.coverimg desc:model.desc count:model.count];
    NSLog(@"radioid == %@", model.radioid);
    [self.view.window.rootViewController presentViewController:listVc animated:YES completion:nil];
}

#pragma mark -- 返回cell高度 --
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
