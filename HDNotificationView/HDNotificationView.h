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
    
}

@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblMessage;

@property (nonatomic, strong) NSTimer *timerHideAuto;

+ (instancetype)sharedInstance;

+ (void)showNotificationViewWithImage:(UIImage *)image title:(NSString *)title message:(NSString *)message onTouch:(void (^)())onTouch;

@end
