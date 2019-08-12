//
//  SIMachOInfo.m
//  TestMachO
//
//  Created by Silence on 2019/8/11.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SIMachOInfo.h"
#import <mach-o/loader.h>
#import <mach-o/fat.h>

#define SIEndianConvert(big, value) \
((big) ? OSSwapInt32((value)) : (value))

void insert(NSString * filePath, NSData * toInsertData, long offset){
    NSFileHandle * fh = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    [fh seekToFileOffset:offset];
    NSData * remainData = [fh readDataToEndOfFile];
    [fh truncateFileAtOffset:offset];
    [fh writeData:toInsertData];
    [fh writeData:remainData];
    [fh synchronizeFile];
    [fh closeFile];
}
void delete(NSString * filePath, long offset, long size){
    NSFileHandle * fh = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    [fh seekToFileOffset:offset + size];
    NSData * remainData = [fh readDataToEndOfFile];
    [fh truncateFileAtOffset:offset];
    [fh writeData:remainData];
    [fh synchronizeFile];
    [fh closeFile];
}

@interface NSFileHandle (Extension)

- (uint32_t)_readUint32;
- (uint32_t)_staticReadUint32;

- (void)_readData:(void *)data length:(NSUInteger)length;
- (void)_staticReadData:(void *)data length:(NSUInteger)length;

- (void)_appendOffset:(unsigned long long)offset;

@end

@implementation NSFileHandle (Extension)

- (uint32_t)_readUint32 {
    size_t length = sizeof(uint32_t);
    uint32_t value;
    [[self readDataOfLength:length] getBytes:&value length:length];
    return value;
}

- (uint32_t)_staticReadUint32 {
    unsigned long long offset = self.offsetInFile;
    uint32_t value = [self _readUint32];
    [self seekToFileOffset:offset];
    return value;
}

- (void)_readData:(void *)data length:(NSUInteger)length {
    [[self readDataOfLength:length] getBytes:data length:length];
}

- (void)_staticReadData:(void *)data length:(NSUInteger)length {
    unsigned long long offset = self.offsetInFile;
    [self _readData:data length:length];
    [self seekToFileOffset:offset];
}

- (void)_appendOffset:(unsigned long long)offset {
    [self seekToFileOffset:self.offsetInFile + offset];
}

@end


@implementation SIMachOInfo {
    NSFileHandle *_handle;
    NSString *_path;
    uint32_t _magic;
}

+ (instancetype)machOWithPath:(NSString *)path {
    return [[self alloc]initWithPath:path];
}

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        _handle = [NSFileHandle fileHandleForReadingAtPath:path];
        _path = path;
        // 读取最前面的四个字节(magic number,魔数,用来标记文件类型)
        _magic = [_handle _staticReadUint32];
        
        // 大小端判断是否为FAT
        if (_magic == FAT_MAGIC || _magic == FAT_CIGAM || _magic == FAT_MAGIC_64 || _magic == FAT_CIGAM_64) {
            [self handleFat:_handle];
        } else if (_magic == MH_MAGIC || _magic == MH_CIGAM || _magic == MH_MAGIC_64 || _magic == MH_CIGAM_64) {
            [self handleMachO:_handle];
        }
    }
    return self;
}

- (void)handleFat:(NSFileHandle *)handle {
    self.fat = YES;
    
    // FAT头
    struct fat_header header;
    [handle _readData:&header length:sizeof(struct fat_header)];
    BOOL bigEndian = (header.magic == FAT_CIGAM);
    
    // 架构数量
    uint32_t archCount = SIEndianConvert(bigEndian, header.nfat_arch);
    NSMutableArray *machOs = [NSMutableArray arrayWithCapacity:archCount];
    for (int i = 0; i < archCount; i++) {
        // 读取一个架构的元数据
        struct fat_arch arch;
        [handle _readData:&arch length:sizeof(struct fat_arch)];
        // 保留偏移
        unsigned long long archMetaOffset = handle.offsetInFile;
        
        // 偏移到架构具体数据的开始
        [handle seekToFileOffset:SIEndianConvert(bigEndian, arch.offset)];
        SIMachOInfo *machO = [[[self class] alloc] init];
        [machO handleMachO:handle];
        if (machO.isEncrypted) {
            self.encrypted = YES;
        }
        [machOs addObject:machO];
        
        // 跳过这个架构的元数据
        [handle seekToFileOffset:archMetaOffset];
    }
    
    self.machOs = machOs;
}

- (void)handleMachO:(NSFileHandle *)handle {
    // magic
    uint32_t magic = [handle _staticReadUint32];
    
    // header
    struct mach_header header;
    int headerLength = sizeof(struct mach_header);
    BOOL bigEndian = (magic == MH_CIGAM);
    BOOL is64bit = NO;
    if (magic == MH_MAGIC_64 || magic == MH_CIGAM_64) {
        headerLength = sizeof(struct mach_header_64);
        bigEndian = (magic == MH_CIGAM_64);
        is64bit = YES;
    }
    
    // 读取头部数据
    [handle _readData:&header length:headerLength];
    uint32_t cputype = SIEndianConvert(bigEndian, header.cputype);
    uint32_t cpusubtype = SIEndianConvert(bigEndian, header.cpusubtype);
    if (cputype == CPU_TYPE_X86_64) {
        self.architecture = @"x86_64";
    } else if (cputype == CPU_TYPE_X86) {
        if (cpusubtype == CPU_SUBTYPE_I386_ALL) {
            self.architecture = @"i386";
        } else if (cpusubtype == CPU_SUBTYPE_X86_ALL) {
            self.architecture = @"x86";
        }
    } else if (cputype == CPU_TYPE_ARM64) {
        self.architecture = @"arm_64";
    } else if (cputype == CPU_TYPE_ARM) {
        if (cpusubtype == CPU_SUBTYPE_ARM_V6) {
            self.architecture = @"arm_v6";
        } else if (cpusubtype == CPU_SUBTYPE_ARM_V6) {
            self.architecture = @"arm_v6";
        } else if (cpusubtype == CPU_SUBTYPE_ARM_V7) {
            self.architecture = @"arm_v7";
        } else if (cpusubtype == CPU_SUBTYPE_ARM_V7S) {
            self.architecture = @"arm_v7s";
        }
    }
    
    // lc的数量
    uint32_t ncmds = SIEndianConvert(bigEndian, header.ncmds);
    // 遍历lc
    for (int i = 0; i < ncmds; i++) {
        struct load_command lc;
        [handle _staticReadData:&lc length:sizeof(struct load_command)];
        
        if (lc.cmd == LC_ENCRYPTION_INFO || lc.cmd == LC_ENCRYPTION_INFO_64) {
            struct encryption_info_command eic;
            [handle _readData:&eic length:sizeof(struct encryption_info_command)];
            self.encrypted = (eic.cryptid != 0);
            break;
        }
        
        [handle seekToFileOffset:handle.offsetInFile + lc.cmdsize];
    }
}

- (void)dealloc {
    [_handle closeFile];
}

@end
