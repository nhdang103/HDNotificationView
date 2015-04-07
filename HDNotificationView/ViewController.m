//
//  ViewController.m
//  HDNotificationView
//
//  Created by iOS Developer on 4/3/15.
//  Copyright (c) 2015 AnG. All rights reserved.
//

#import "ViewController.h"
#import "HDNotificationView.h"

#define PUSH_NOTI_MESSAGE_1         @"Chào mừng bạn đến với style-X !!!"
#define PUSH_NOTI_MESSAGE_2         @"a"
#define PUSH_NOTI_MESSAGE_3         @"Push noti"
#define PUSH_NOTI_MESSAGE_4         @"Push noti message 4"
#define PUSH_NOTI_MESSAGE_5         @"Chào mừng bạn đến với style-X !!! Chào mừng bạn đến với style-X !!! Chào mừng bạn đến với style-X !!!"

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
    
    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"Icon-72"]
                                                title:@"Style-X"
                                              message:stringValue
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
