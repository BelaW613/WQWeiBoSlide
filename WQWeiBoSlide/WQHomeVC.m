//
//  WQHomeVC.m
//  WQWeiBoSlide
//
//  Created by qian wan on 2017/5/9.
//  Copyright © 2017年 qian wan. All rights reserved.
//

#import "WQHomeVC.h"
#import "WQHeadView.h"

#define kFloatingViewMinimumHeight 108
#define kFloatingViewMaximumHeight 245

@interface WQHomeVC ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet WQHeadView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewTopConstraint;

@property (nonatomic, strong) id savedDelegate;
@end

@implementation WQHomeVC

- (void)dealloc {
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;//因为会利用到tableView的contentInset，所以不想系统给我们改，最好把这个设置为UIRectEdgeNone,否则在viewDidAppear的时候tableView的contentInset会变
    self.tableView.contentInset = UIEdgeInsetsMake(kFloatingViewMaximumHeight, 0, 0, 0);
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.backButton addTarget:self action:@selector(handleBackButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    //测试
    //图片点击事件
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, self.headImg.frame.size.width, self.headImg.frame.size.height);
    [btn addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    self.headImg.userInteractionEnabled = YES;
//    [self.headImg addSubview:btn];
    
}

- (void)tapClick
{
    NSLog(@"tapClick");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.savedDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;//这里是为了保留系统的右滑返回手势
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = self.savedDelegate;//这里是为了保留系统的右滑返回手势
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"index : (%ld, %ld)", (long)indexPath.section, (long)indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    switch (self.style) {
        //效果一
        case 1:
        {
            if ([keyPath isEqualToString:@"contentOffset"]) {
                CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
                if (offset.y <= 0 && -offset.y >= kFloatingViewMaximumHeight) {
                    self.headerViewHeightConstraint.constant = - offset.y;
                } else if (offset.y < 0 && -offset.y < kFloatingViewMaximumHeight && -offset.y > kFloatingViewMinimumHeight) {
                    self.headerViewHeightConstraint.constant = 200;
                    self.headerViewTopConstraint.constant = -offset.y - kFloatingViewMaximumHeight;
                } else {
                    self.headerViewTopConstraint.constant = kFloatingViewMinimumHeight - kFloatingViewMaximumHeight;
                }
            }
        }
            break;
        //效果二
        case 2:
        {
            if ([keyPath isEqualToString:@"contentOffset"]) {
                CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
                if (offset.y <= 0 && -offset.y >= kFloatingViewMaximumHeight) {
                    self.navView.alpha = 0;
                    self.headerViewTopConstraint.constant = -offset.y - kFloatingViewMaximumHeight;
                } else if (offset.y < 0 && -offset.y < kFloatingViewMaximumHeight && -offset.y > kFloatingViewMinimumHeight) {
                    self.navView.alpha = -offset.y/kFloatingViewMaximumHeight;
                    self.headerViewTopConstraint.constant = -offset.y - kFloatingViewMaximumHeight;
                } else {
                    self.navView.alpha = 1;
                    self.headerViewTopConstraint.constant = kFloatingViewMinimumHeight - kFloatingViewMaximumHeight;
                }
            }
        }
            break;
        //效果三
        case 3:
        {
            if ([keyPath isEqualToString:@"contentOffset"]) {
                CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
                if (offset.y <= 0 && -offset.y >= kFloatingViewMinimumHeight) {
                    self.headerViewHeightConstraint.constant = - offset.y;
                } else {
                    self.headerViewHeightConstraint.constant = 64;
                }
            }
        }
            break;
        default:
            break;
    }
    
    
}


#pragma mark - buttonAction

- (void)handleBackButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
