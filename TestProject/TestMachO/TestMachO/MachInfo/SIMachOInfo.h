//
//  SIMachOInfo.h
//  TestMachO
//
//  Created by Silence on 2019/8/11.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SIMachOModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMachOInfo : NSObject

/** 架构名称 */
@property (copy, nonatomic) NSString *architecture;
/** 是否被加密 */
@property (assign, nonatomic, getter=isEncrypted) BOOL encrypted;
/** 是否为胖进制文件 */
@property (assign, nonatomic, getter=isFat) BOOL fat;
@property (strong, nonatomic) NSArray *machOs;
@property (strong, nonatomic) SIMachHeader *header;

+ (instancetype)machOWithPath:(NSString *)path;
- (instancetype)initWithPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
