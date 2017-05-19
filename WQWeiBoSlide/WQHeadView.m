//
//  WQHeadView.m
//  WQWeiBoSlide
//
//  Created by qian wan on 2017/5/9.
//  Copyright © 2017年 qian wan. All rights reserved.
//

#import "WQHeadView.h"

@implementation WQHeadView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *result = [super hitTest:point withEvent:event];
//    if (result == self) {
//        return nil;
//    } else {
//        return result;
//    }

    UIView *result = [super hitTest:point withEvent:event];
    if ([result isKindOfClass:[UIButton class]]) {
        return  result;
    } else {
        return nil;
    }
    
    
}


@end
