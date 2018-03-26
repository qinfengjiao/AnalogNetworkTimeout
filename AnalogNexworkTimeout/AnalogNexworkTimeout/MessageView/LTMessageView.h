//
//  LTMessageView.h
//  JukeboxController
//
//  Created by qinfengjiao on 2017/9/27.
//  Copyright © 2017年 AmyQin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LTMessageViewType) {
    LTMessageViewTypeMessage = 0,			// 信息
    LTMessageViewTypeSuccess,				// 成功
    LTMessageViewTypeError,					// 错误
    LTMessageViewTypeWarning,				// 警告
    LTMessageViewTypeCustom					// 自定义
};

@interface LTMessageView : UIView

- (instancetype)initWithTitle:(NSString *)title messageType:(LTMessageViewType)type duration:(CGFloat)duration;
- (void)show;

@end
