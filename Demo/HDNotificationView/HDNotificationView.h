//
//  HDNotificationView.h
//  HDNotificationView
//
//  Created by iOS Developer on 4/3/15.
//  Copyright (c) 2015 AnG. All rights reserved.
//
//
// Modified by Vicente Crespo Penadés - 19 Nov 2015
// vicente.crespo.penades@gmail.com
//

#import <UIKit/UIKit.h>

@interface HDNotificationView : UIToolbar
{
    void (^ _onTouch)();
    
    UIImageView *_imgIcon;
    UILabel *_lblTitle;
    UILabel *_lblMessage;
    
    NSTimer *_timerHideAuto;
}

+ (instancetype)sharedInstance;

+ (void) configureForAutoHideSeconds: (CGFloat) autoHideSeconds;

+ (void)showNotificationViewWithImage:(UIImage *)image title:(NSString *)title message:(NSString *)message;
+ (void)showNotificationViewWithImage:(UIImage *)image title:(NSString *)title message:(NSString *)message isAutoHide:(BOOL)isAutoHide;
+ (void)showNotificationViewWithImage:(UIImage *)image title:(NSString *)title message:(NSString *)message isAutoHide:(BOOL)isAutoHide onTouch:(void (^)())onTouch;

+ (void)hideNotificationView;
+ (void)hideNotificationViewOnComplete:(void (^)())onComplete;

@end
