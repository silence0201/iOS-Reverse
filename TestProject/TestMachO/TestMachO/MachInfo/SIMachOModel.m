//
//  SIMachOModel.m
//  TestMachO
//
//  Created by Silence on 2019/8/12.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SIMachOModel.h"

@implementation SIMachHeader : NSObject
- (instancetype)init {
    if (self = [super init]) {
        _offset = 0;
        _machHeader = nil;
        _machHeader64 = nil;
    }
    return self;
}
@end

@implementation SILoadCommand : NSObject
- (instancetype)init {
    if (self = [super init]) {
        _offset = 0;
        _loadCmd = nil;
    }
    return self;
}
@end

@implementation SIDylibCommand : NSObject
- (instancetype)init {
    if (self = [super init]) {
        _offset = 0;
        _dylibCmd = nil;
    }
    return self;
}
@end

