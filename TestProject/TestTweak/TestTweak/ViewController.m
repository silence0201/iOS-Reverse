//
//  ViewController.m
//  TestTweak
//
//  Created by Silence on 2019/8/10.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

void test() {
    printf("Hello,World");
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self click];
}

- (void)click {
    UISwitch *s = [UISwitch new];
    s.center = self.view.center;
    [self.view addSubview:s];
    test();
}


@end
