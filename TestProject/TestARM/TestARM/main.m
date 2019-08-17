//
//  main.m
//  TestARM
//
//  Created by Silence on 2019/8/17.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "arm.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        int a = 20;
        int b = 10;
        if (a > b) {
            printf("a>b");
        }else {
            NSLog(@"a<b");
        }
        
        
        test();
        
        int c = 2;
        load();
        //NSLog(@"%d",add(2, 4));
        //NSLog(@"%d",sub(6, 2));
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
