//
//  DetectionTimeout.h
//  JukeboxController
//
//  Created by Laxton on 2017/7/24.
//  Copyright © 2017年 AmyQin. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *LTAskTimeoutNotification = @"LTAskTimeoutNotification";
static NSString *const LTErrorDomain = @"LTErrorDomain";
typedef NS_ENUM(NSInteger,LTErrorCode) {
    kTLErrorCodeRequestTimeout
};

@interface DetectionTimeout : NSObject

@property (nonatomic,assign)BOOL isTime;
@property (nonatomic,strong) void (^failureOperation)(NSError *error);
@property (nonatomic,assign) BOOL isShowHUDView;

+ (instancetype)sharedDetectionTimeout;

- (void)startTimer;
- (void)endTimer;
@end
