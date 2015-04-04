//
//  ViewController.m
//  HDNotificationView
//
//  Created by iOS Developer on 4/3/15.
//  Copyright (c) 2015 AnG. All rights reserved.
//

#import "ViewController.h"
#import "HDNotificationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonShowNotiViewTouchUpInside:(id)sender
{
    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"Icon-72"]
                                                title:@"Style-X"
                                              message:@"🎀 Toppie 🎀 Chụp hình Style Đẹp (free), 10h ngày 4/4, 3A Tôn Đức Thắng, Q1. Khi đi nhớ mang theo tiền nhé :D"
                                          isAutoClose:YES
                                              onTouch:^{
                                                  NSLog(@"alo 1 3 4");
                                              }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
