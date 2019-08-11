//
//  main.m
//  TestMachO
//
//  Created by Silence on 2019/8/11.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIMachOInfo.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SpringBoard" ofType:nil];
        SIMachOInfo *machInfo = [SIMachOInfo machOWithPath:path];
        NSLog(@"%@",machInfo);
        return 0;
    }
}
