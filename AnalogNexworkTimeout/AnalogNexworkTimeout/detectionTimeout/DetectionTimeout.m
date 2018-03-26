//
//  DetectionTimeout.m
//  JukeboxController
//
//  Created by Laxton on 2017/7/24.
//  Copyright © 2017年 AmyQin. All rights reserved.
//

#import "DetectionTimeout.h"
#import "LTMessageView.h"
#import "MBProgressHUD.h"

#define kXmppStreamTimeout 5    //设置超时的时间
static int totalTimer = 0;

@interface DetectionTimeout()
@property (nonatomic,strong)MBProgressHUD *hud;
@property (atomic,strong) dispatch_source_t timer;
@end

@implementation DetectionTimeout

+ (instancetype)sharedDetectionTimeout{
    static DetectionTimeout *detectionTimeout;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        detectionTimeout = [[DetectionTimeout alloc] init];
    });
    return detectionTimeout;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.isShowHUDView = YES;
        __weak typeof(self) weakSelf = self;
        self.failureOperation = ^(NSError *error){
            LTMessageView *messageView = [[LTMessageView alloc] initWithTitle:error.localizedDescription messageType:LTMessageViewTypeMessage duration:0];
            [messageView show];
            [weakSelf.hud hideAnimated:YES];
        };
    }
    return self;
}
- (void)startTimer{
    self.isTime = YES;
    //创建一个定时器
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        totalTimer ++;
        NSLog(@"%d",totalTimer);
        if (totalTimer == kXmppStreamTimeout) {
            //通知主线程超时
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *error = [NSError errorWithDomain:LTErrorDomain code:kTLErrorCodeRequestTimeout userInfo:@{NSLocalizedDescriptionKey:@"网络请求超时"}];
                self.failureOperation(error);
                [[NSNotificationCenter defaultCenter] postNotificationName:LTAskTimeoutNotification object:nil];
            });
            [self endTimer];
            totalTimer = 0;
        }
        });
    dispatch_resume(self.timer);
    if (self.isShowHUDView) {
        self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    self.isShowHUDView = YES;
}

- (void)endTimer{
    self.isTime = NO;
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
    self.timer = nil;
    totalTimer = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isShowHUDView) {
            [self.hud hideAnimated:YES];
        }
    });
}

@end
