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
    BOOL bigEndian = (header.magic == FAT_CIGAM || header.magic == FAT_CIGAM_64);
    BOOL is64bit = (header.magic == FAT_MAGIC_64 || header.magic == FAT_CIGAM_64);
    // 架构数量
    uint32_t archCount = SIEndianConvert(bigEndian, header.nfat_arch);
    NSMutableArray *machOs = [NSMutableArray arrayWithCapacity:archCount];
    NSMutableArray *fatArchs = [NSMutableArray arrayWithCapacity:archCount];
    for (int i = 0; i < archCount; i++) {
        SIFatArch *fatArch = [[SIFatArch alloc]init];
        fatArch.magic = _magic;
        // 读取一个架构的元数据
        if (is64bit) {
            struct fat_arch_64 arch64;
            [handle _readData:&arch64 length:sizeof(struct fat_arch_64)];
            fatArch.fatArch_64 = arch64;
            fatArch.offset = arch64.offset;
        } else {
            struct fat_arch arch;
            [handle _readData:&arch length:sizeof(struct fat_arch)];
            fatArch.fatArch = arch;
            fatArch.offset = arch.offset;
        }

        // 保留偏移
        unsigned long long archMetaOffset = handle.offsetInFile;
        
        // 偏移到架构具体数据的开始
        [handle seekToFileOffset:SIEndianConvert(bigEndian, fatArch.offset)];
        SIMachOInfo *machO = [[[self class] alloc] init];
        [machO handleMachO:handle];
        if (machO.isEncrypted) {
            self.encrypted = YES;
        }
        [machOs addObject:machO];
        [fatArchs addObject:fatArch];
        
        // 跳过这个架构的元数据
        [handle seekToFileOffset:archMetaOffset];
    }
    
    self.machOs = machOs;
    self.fatArchs = fatArchs;
}

- (void)handleMachO:(NSFileHandle *)handle {
    // magic
    uint32_t magic = [handle _staticReadUint32];
    
    BOOL bigEndian = (magic == MH_CIGAM || magic == MH_CIGAM_64);
    BOOL is64bit = (magic == MH_CIGAM_64 || magic == MH_MAGIC_64);
    
    _header = [[SIMachHeader alloc] init];
    _header.magic = magic;

    uint32_t cputype;
    uint32_t cpusubtype;
    // lc的数量
    uint32_t ncmds;
    long load_commands_offset;
    
    // 读取头部数据
    if (is64bit) {
        struct mach_header_64 header64;
        _header.offset = sizeof(struct mach_header_64);
        [handle _readData:&header64 length:_header.offset];
        _header.machHeader64 = header64;
        cputype = SIEndianConvert(bigEndian, header64.cputype);
        cpusubtype = SIEndianConvert(bigEndian, header64.cpusubtype);
        ncmds = SIEndianConvert(bigEndian, header64.ncmds);
        load_commands_offset = _header.offset;
    }else {
        struct mach_header header;
        _header.offset = sizeof(struct mach_header);
        [handle _readData:&header length:_header.offset];
        _header.machHeader = header;
        cputype = SIEndianConvert(bigEndian, header.cputype);
        cpusubtype = SIEndianConvert(bigEndian, header.cpusubtype);
        ncmds = SIEndianConvert(bigEndian, header.ncmds);
        load_commands_offset = _header.offset;
    }

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
    // 遍历lc
    NSMutableArray *commandArr = [NSMutableArray array];
    for (int i = 0; i < ncmds; i++) {
        SILoadCommand *command = [[SILoadCommand alloc]init];
        command.offset = load_commands_offset;
        struct load_command lc;
        [handle _staticReadData:&lc length:sizeof(struct load_command)];
        command.loadCmd = lc;
        load_commands_offset += lc.cmdsize;
        
        if (lc.cmd == LC_ENCRYPTION_INFO || lc.cmd == LC_ENCRYPTION_INFO_64) {
            struct encryption_info_command eic;
            [handle _readData:&eic length:sizeof(struct encryption_info_command)];
            self.encrypted = (eic.cryptid != 0);
        }
        
        [commandArr addObject:command];
        
        [handle seekToFileOffset:handle.offsetInFile + lc.cmdsize];
    }
    self.commands = commandArr;
}

- (void)dealloc {
    [_handle closeFile];
}

@end
