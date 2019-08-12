//
//  SIMachOModel.h
//  TestMachO
//
//  Created by Silence on 2019/8/12.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <mach-o/loader.h>
#include <mach-o/swap.h>
#include <mach-o/fat.h>

@interface SIMachHeader : NSObject
@property (nonatomic,assign) long offset;
@property (nonatomic,assign) uint32_t magic;
@property (nonatomic,assign) struct mach_header * machHeader;
@property (nonatomic,assign) struct mach_header_64 * machHeader64;
@end

@interface SIDylibCommand : NSObject
@property (nonatomic,assign) long offset;
@property (nonatomic,assign) struct dylib_command * dylibCmd;
@end

@interface SILoadCommand : NSObject
@property (nonatomic,assign) long offset;
@property (nonatomic,assign) struct load_command * loadCmd;
@end

