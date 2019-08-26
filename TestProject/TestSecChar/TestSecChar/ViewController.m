//
//  ViewController.m
//  TestSecChar
//
//  Created by Silence on 2019/8/26.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*NSString *helloWorld = @"Hello,World";
    const char *cStr = [helloWorld cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned long length = strlen(cStr);
    for (int i = 0; i < length;i++) {
        NSLog(@"%d",cStr[i] ^ 5);
    }*/
    
    const char str[] = {77,96,105,105,106,41,82,106,119,105,97,0};
    NSMutableString *helloWorld = [NSMutableString string];
    for (int i = 0;i<strlen(str);i++) {
        [helloWorld appendFormat:@"%c",str[i] ^ 5];
    }
    
    NSLog(@"%@",helloWorld);
}


@end
