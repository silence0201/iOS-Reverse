//
//  ViewController.m
//  TestJailbreak
//
//  Created by Silence on 2019/8/4.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "JailbreakCheck.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([JailbreakCheck isDeviceJailbroken]) {
        NSLog(@"设备已越狱");
        self.tipLabel.text = @"设备已越狱";
    } else {
        NSLog(@"设备未越狱");
        self.tipLabel.text = @"设备未越狱";
    }
}

@end
