//
//  HDNotificationView.h
//  HDNotificationView
//
//  Created by iOS Developer on 4/3/15.
//  Copyright (c) 2015 AnG. All rights reserved.
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

+ (void)showNotificationViewWithImage:(UIImage *)image title:(NSString *)title message:(NSString *)message;
+ (void)showNotificationViewWithImage:(UIImage *)image title:(NSString *)title message:(NSString *)message isAutoClose:(BOOL)isAutoClose onTouch:(void (^)())onTouch;

+ (void)hideNotificationViewOnComplete:(void (^)())onComplete;

@end
