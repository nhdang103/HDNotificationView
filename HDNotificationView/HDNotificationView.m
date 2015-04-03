//
//  HDNotificationView.m
//  HDNotificationView
//
//  Created by iOS Developer on 4/3/15.
//  Copyright (c) 2015 AnG. All rights reserved.
//

#import "HDNotificationView.h"

#define APP_DELEGATE        [UIApplication sharedApplication].delegate

#define NOTIFICATION_VIEW_FRAME_HEIGHT       68.0f

#define IMAGE_ICON_FRAME    CGRectMake(15.0f, 8.0f, 20.0f, 20.0f)
#define IMAGE_ICON_CORNER_RADIUS    3.0f

#define NOTIFICATION_VIEW_SHOWING_TIME                  5.0f    //second
#define NOTIFICATION_VIEW_SHOWING_ANIMATION_TIME        0.5f    //second

@implementation HDNotificationView

+ (instancetype)sharedInstance
{
    static id _sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, [[UIScreen mainScreen] bounds].size.width, NOTIFICATION_VIEW_FRAME_HEIGHT)];
    if (self) {
        [self setUpUI];
    }
    
    return self;
}

- (void)setUpUI
{
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        self.barTintColor = nil;
        self.translucent = YES;
        self.barStyle = UIBarStyleBlack;
    }
    else {
        [self setTintColor:[UIColor colorWithRed:5 green:31 blue:75 alpha:1]];
    }
    
    self.layer.zPosition = MAXFLOAT;
    self.backgroundColor = [UIColor clearColor];
    self.multipleTouchEnabled = NO;
    self.exclusiveTouch = YES;
    
    _imgIcon = [[UIImageView alloc] initWithFrame:IMAGE_ICON_FRAME];
    [_imgIcon setContentMode:UIViewContentModeScaleAspectFill];
    [_imgIcon.layer setCornerRadius:IMAGE_ICON_CORNER_RADIUS];
    [_imgIcon setClipsToBounds:YES];
    [self addSubview:_imgIcon];
    
    _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(45.0f, 3.0f, [[UIScreen mainScreen] bounds].size.width - 45.0f, 26.0f)];
    [_lblTitle setTextColor:[UIColor whiteColor]];
    [_lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0f]];
    [_lblTitle setNumberOfLines:1];
    [self addSubview:_lblTitle];
    
    _lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(45.0f, 29.0f, [[UIScreen mainScreen] bounds].size.width - 45.0f, 39.0f)];
    [_lblMessage setTextColor:[UIColor whiteColor]];
    [_lblMessage setFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0f]];
    [_lblMessage setNumberOfLines:2];
    [self addSubview:_lblMessage];
    
}

+ (void)showNotificationViewWithImage:(UIImage *)image title:(NSString *)title message:(NSString *)message onTouch:(void (^)())onTouch
{
    // Prepare frame
    CGRect frame = [HDNotificationView sharedInstance].frame;
    frame.size.height = -frame.size.height;
    [HDNotificationView sharedInstance].frame = frame;
    
    // Image
    [[HDNotificationView sharedInstance].imgIcon setImage:image];
    
    // Title
    [[HDNotificationView sharedInstance].lblTitle setText:title];
    
    // Message
    [[HDNotificationView sharedInstance].lblMessage setText:message];
    
    // Add to window
    APP_DELEGATE.window.windowLevel = UIWindowLevelStatusBar;
    [APP_DELEGATE.window addSubview:[HDNotificationView sharedInstance]];
    
    [UIView animateWithDuration:NOTIFICATION_VIEW_SHOWING_ANIMATION_TIME
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         CGRect frame = [HDNotificationView sharedInstance].frame;
                         frame.origin.y += frame.size.height;
                         [HDNotificationView sharedInstance].frame = frame;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
    // Schedule to hide
    [HDNotificationView sharedInstance].timerHideAuto =
    [NSTimer scheduledTimerWithTimeInterval:NOTIFICATION_VIEW_SHOWING_TIME
                                     target:[HDNotificationView class]
                                   selector:@selector(hideNotificationViewOnComplete:)
                                   userInfo:nil
                                    repeats:NO];
}

+ (void)hideNotificationViewOnComplete:(void (^)())onComplete
{
    
}


@end
