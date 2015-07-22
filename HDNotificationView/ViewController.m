//
//  ViewController.m
//  HDNotificationView
//
//  Created by iOS Developer on 4/3/15.
//  Copyright (c) 2015 AnG. All rights reserved.
//

#import "ViewController.h"
#import "HDNotificationView.h"

#define PUSH_NOTI_MESSAGE_1         @"Welcome to Style-X !!!"
#define PUSH_NOTI_MESSAGE_2         @"Hello !!!"
#define PUSH_NOTI_MESSAGE_3         @"This is a push notificaiton message!"
#define PUSH_NOTI_MESSAGE_4         @"You can add icon to this notification view on the left!"
#define PUSH_NOTI_MESSAGE_5         @"You have a message with long text which will show in two lines of notification view!"

@interface ViewController()
{
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonShowNotiViewTouchUpInside:(id)sender
{
    /// Random message content
    NSInteger randomValue = arc4random()%5;
    
    NSString *stringValue = @"";
    switch (randomValue) {
        case 0:
        {
            stringValue = PUSH_NOTI_MESSAGE_1;
            break;
        }
        case 1:
        {
            stringValue = PUSH_NOTI_MESSAGE_2;
            break;
        }
        case 2:
        {
            stringValue = PUSH_NOTI_MESSAGE_3;
            break;
        }
        case 3:
        {
            stringValue = PUSH_NOTI_MESSAGE_4;
            break;
        }
        case 4:
        {
            stringValue = PUSH_NOTI_MESSAGE_5;
            break;
        }
            
        default:
            break;
    }
    
    /// Show notification view
    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"sampleIcon"]
                                                title:@"Style-X"
                                              message:stringValue
                                          isAutoHide:YES
                                              onTouch:^{
                                                  
                                                  /// On touch handle. You can hide notification view or do something
                                                  [HDNotificationView hideNotificationViewOnComplete:nil];
                                              }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
