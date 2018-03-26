//
//  LTMessageView.m
//  JukeboxController
//
//  Created by qinfengjiao on 2017/9/27.
//  Copyright © 2017年 AmyQin. All rights reserved.
//
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#import "LTMessageView.h"
#import "PureLayout.h"

@interface LTMessageView()
{
    CGFloat kDefault_height;
}
@end

@implementation LTMessageView

- (instancetype)initWithTitle:(NSString *)title messageType:(LTMessageViewType)type duration:(CGFloat)duration{
    self = [super init];
    kDefault_height = kStatusBarHeight + 44;
    if (self) {
        if (type == LTMessageViewTypeMessage || type == LTMessageViewTypeSuccess) {
            [self setBackgroundColor:[UIColor greenColor]];
        }else if (type == LTMessageViewTypeError){
            [self setBackgroundColor:[UIColor redColor]];
        }else if (type == LTMessageViewTypeWarning){
            [self setBackgroundColor:[UIColor yellowColor]];
        }else {
            [self setBackgroundColor:[UIColor greenColor]];
        }
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setText:title];
        [titleLabel setTextColor:[UIColor whiteColor]];
        titleLabel.numberOfLines = 0;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:titleLabel];
        [titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kStatusBarHeight, 8, 0, 0)];
    }
    return self;
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.frame = CGRectMake(0, -kDefault_height, [UIScreen mainScreen].bounds.size.width, kDefault_height);
    /*usingSpringWithDamping的范围为0.0f到1.0f，数值越小「弹簧」的振动效果越明显initialSpringVelocity则表示初始的速度，数值越大一开始移动越快。*/
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kDefault_height);
    } completion:^(BOOL finished) {
        [self hiedMessageView];
    }];
}

- (void)hiedMessageView{
    [UIView animateWithDuration:0.6 delay:1 usingSpringWithDamping:0.8 initialSpringVelocity:0.0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        self.frame = CGRectMake(0, -kDefault_height, [UIScreen mainScreen].bounds.size.width, kDefault_height);

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}







@end
