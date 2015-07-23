## Introduction
HDNotificationView appears notification view like system.

![alt tag](./Assets/screen_portrait.gif) ![alt tag](./Assets/screen_landscape.gif)

## Requirement
- iOS 7.0+

## Installation
Add two files **HDNotificationView.h** and **HDNotificationView.m** to your project.

Go ahead and import HDNotificationView to your file.

```objective-c
#import "HDNotificationView.h"
```

## Usage
Show notification view with **image** (icon), **title** and **message**
```objective-c
+ (void)showNotificationViewWithImage:(UIImage *)image 
                                title:(NSString *)title 
                              message:(NSString *)message;     /// isAutoHide = YES

+ (void)showNotificationViewWithImage:(UIImage *)image 
                                title:(NSString *)title 
                              message:(NSString *)message
                           isAutoHide:(BOOL)isAutoHide;       /// onTouch = nil
                           
+ (void)showNotificationViewWithImage:(UIImage *)image
                                title:(NSString *)title 
                              message:(NSString *)message 
                           isAutoHide:(BOOL)isAutoHide 
                              onTouch:(void (^)())onTouch;
```

Hide notification view
```objective-c
+ (void)hideNotificationView;

+ (void)hideNotificationViewOnComplete:(void (^)())onComplete;
```

## License
HDNotificationView is available under the MIT License. See the [LICENSE](./License) for details.
