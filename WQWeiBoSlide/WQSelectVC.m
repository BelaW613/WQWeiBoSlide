//
//  WQSelectVC.m
//  WQWeiBoSlide
//
//  Created by qian wan on 2017/5/9.
//  Copyright © 2017年 qian wan. All rights reserved.
//

#import "WQSelectVC.h"
#import "WQHomeVC.h"

@interface WQSelectVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation WQSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"类型 : (%ld)", (long)indexPath.row+1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WQHomeVC *vc = [WQHomeVC new];
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    vc = [board instantiateViewControllerWithIdentifier: @"WQHomeVC"];
    vc.style = indexPath.row+1;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
