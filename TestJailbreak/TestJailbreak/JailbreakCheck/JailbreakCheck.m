//
//  JailbreakCheck.m
//  TestJailbreak
//
//  Created by Silence on 2019/8/4.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "JailbreakCheck.h"
#import "LOOCryptString.h"
#import <UIKit/UIKit.h>

// Defines
#define FORCE_INLINE inline __attribute__((always_inline))

// Jailbreak checks
#import <sys/stat.h>
#import <arpa/inet.h>
#import <mach-o/dyld.h>

// Inline functions
FORCE_INLINE BOOL checkJailbreakSymlinks(void);
FORCE_INLINE BOOL checkJailbreakSymLink(NSString *checkPath);

FORCE_INLINE BOOL checkRootPermissions(void);

FORCE_INLINE BOOL checkJailbreakFiles(void);
FORCE_INLINE BOOL checkJailbreakFile(NSString *checkPath);

FORCE_INLINE BOOL checkReadWritePermissions(void);

FORCE_INLINE BOOL checkPortOpen(short port);
FORCE_INLINE BOOL checkCydiaScheme(void);

FORCE_INLINE BOOL checkForInjection(void);

@implementation JailbreakCheck

+ (BOOL)isDeviceJailbroken {
    return checkJailbreakFiles() // 1a
    || checkRootPermissions() // 1b (1c shouldn't implement)
    || checkJailbreakSymlinks() // 1d
    || checkReadWritePermissions() // 1e
    || checkForInjection() // 2d
    || checkPortOpen(22) // 3
    || checkCydiaScheme(); // 4
}

@end

#pragma mark - Jailbreak checks
BOOL checkJailbreakFiles() {
    NSArray *fileChecks = @[LOO_CRYPT_STR_N("/private/var/stash", 18),
                            LOO_CRYPT_STR_N("/private/var/lib/apt", 20),
                            LOO_CRYPT_STR_N("/private/var/tmp/cydia.log", 26),
                            LOO_CRYPT_STR_N("/private/var/mobile/Library/SBSettings/Themes", 45),
                            LOO_CRYPT_STR_N("/Library/MobileSubstrate/MobileSubstrate.dylib", 46),
                            LOO_CRYPT_STR_N("/Library/MobileSubstrate/DynamicLibraries/Veency.plist", 54),
                            LOO_CRYPT_STR_N("/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist", 57),
                            LOO_CRYPT_STR_N("/System/Library/LaunchDaemons/com.ikey.bbot.plist", 49),
                            LOO_CRYPT_STR_N("/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist", 60),
                            LOO_CRYPT_STR_N("/var/cache/apt", 14),
                            LOO_CRYPT_STR_N("/var/lib/apt", 12),
                            LOO_CRYPT_STR_N("/var/log/syslog", 15),
                            LOO_CRYPT_STR_N("/var/tmp/cydia.log", 18),
                            LOO_CRYPT_STR_N("/usr/bin/sshd", 13),
                            LOO_CRYPT_STR_N("/etc/apt", 8),
#if !(TARGET_OS_SIMULATOR)
                            LOO_CRYPT_STR_N("/bin/bash", 9),
                            LOO_CRYPT_STR_N("/usr/sbin/sshd", 14),
                            LOO_CRYPT_STR_N("/usr/libexec/ssh-keysign", 24),
                            LOO_CRYPT_STR_N("/usr/libexec/sftp-server", 24),
                            LOO_CRYPT_STR_N("/etc/ssh/sshd_config", 20),
                            LOO_CRYPT_STR_N("/bin/sh", 7),
#endif
                            LOO_CRYPT_STR_N("/Applications/Cydia.app", 23),
                            LOO_CRYPT_STR_N("/Applications/RockApp.app", 25),
                            LOO_CRYPT_STR_N("/Applications/Icy.app", 21),
                            LOO_CRYPT_STR_N("/Applications/WinterBoard.app", 29),
                            LOO_CRYPT_STR_N("/Applications/SBSettings.app", 28),
                            LOO_CRYPT_STR_N("/Applications/MxTube.app", 24),
                            LOO_CRYPT_STR_N("/Applications/IntelliScreen.app", 31),
                            LOO_CRYPT_STR_N("/Applications/FakeCarrier.app", 29),
                            LOO_CRYPT_STR_N("/Applications/blackra1n.app", 27)];
    
    for (NSString *checkPath in fileChecks) {
        if (checkJailbreakFile(checkPath)) {
            return YES;
        }
    }
    
    return NO;
}

BOOL checkJailbreakSymlinks() {
    NSArray *linksChecks = @[LOO_CRYPT_STR_N("/Library/Ringtones", 18),
                             LOO_CRYPT_STR_N("/Library/Wallpaper", 18),
                             LOO_CRYPT_STR_N("/usr/arm-apple-darwin9", 22),
                             LOO_CRYPT_STR_N("/usr/include", 12),
                             LOO_CRYPT_STR_N("/usr/libexec", 12),
                             LOO_CRYPT_STR_N("/usr/share", 10),
                             LOO_CRYPT_STR_N("/Applications", 13)];
    
    for (NSString *checkPath in linksChecks) {
        if (checkJailbreakSymLink(checkPath)) {
            return YES;
        }
    }
    
    return NO;
}

BOOL checkCydiaScheme() {
    if([[UIApplication sharedApplication] canOpenURL:
        [NSURL URLWithString:LOO_CRYPT_STR_N("cydia://package/com.com.com", 27)]]){
        return YES;
    }
    
    return NO;
}

BOOL checkReadWritePermissions()
{
    NSError *error;
    NSString *stringToBeWritten = @"0";
    [stringToBeWritten writeToFile:LOO_CRYPT_STR_N("/private/jailbreak.test", 23)
                        atomically:YES
                          encoding:NSUTF8StringEncoding error:&error];
    
    if (error == nil)
    {
        return YES;
    }
    
    return NO;
}

BOOL checkRootPermissions() {
    if (access([LOO_CRYPT_STR_N("/", 1) UTF8String], R_OK|W_OK) > 0 ) {
        return YES;
    }
    return NO;
}

BOOL checkJailbreakSymLink(NSString *checkPath) {
    struct stat s;
    
    if (lstat([checkPath UTF8String], &s) == 0){
        if (S_ISLNK(s.st_mode) == 1) {
            return YES;
        }
    }
    
    return NO;
}

BOOL checkJailbreakFile(NSString *checkPath) {
    struct stat s;
    if (stat([checkPath UTF8String], &s) == 0){
        return YES;
    }
    return NO;
}

BOOL checkPortOpen(short port) {
    struct sockaddr_in addr;
    int sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    
    if (inet_pton(AF_INET, "127.0.0.1", &addr.sin_addr)) {
        int result = connect(sock, (struct sockaddr *)&addr,
                             sizeof(addr));
        
        if(result==0) {
            close(sock);
            return YES;
        }
        
        close(sock);
    }
    return NO;
}

BOOL checkForInjection() {
    uint32_t count = _dyld_image_count();
    
    char* evilLibs[] = {
        "Substrate", "cycript"
    };
    
    for(uint32_t i = 0; i < count; i++) {
        const char *dyld = _dyld_get_image_name(i);
        int slength = (int)strlen(dyld);
        int j;
        for(j = slength - 1; j>= 0; --j)
            if(dyld[j] == '/') break;
        
        char *name = strndup(dyld + ++j, slength - j);
        
        for(int x=0; x < sizeof(evilLibs) / sizeof(char*); x++) {
            if(strstr(name, evilLibs[x]) || strstr(dyld, evilLibs[x])) {
                free(name);
                return YES;
            }
        }
        
        free(name);
    }
    
    return NO;
}

