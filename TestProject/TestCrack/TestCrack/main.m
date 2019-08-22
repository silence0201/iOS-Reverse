//
//  main.m
//  TestCrack
//
//  Created by Silence on 2019/8/22.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    int password = 0;
    while (password != 123456) {
        printf("请输入正确的密码：");
        scanf("%d", &password);
    }
    printf("密码输入正确，欢迎使用XX管理系统！\n");
    return 0;
}
