//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSFileManager.h"

@interface NSFileManager (Helper)
+ (id)sizeFormatted:(id)arg1;
+ (_Bool)isNotError:(id *)arg1;
+ (_Bool)writeFileAtPath:(id)arg1 content:(id)arg2 error:(id *)arg3;
+ (_Bool)writeFileAtPath:(id)arg1 content:(id)arg2;
+ (id)sizeFormattedOfDirectoryAtPath:(id)arg1 error:(id *)arg2;
+ (id)sizeFormattedOfDirectoryAtPath:(id)arg1;
+ (id)sizeFormattedOfFileAtPath:(id)arg1 error:(id *)arg2;
+ (id)sizeFormattedOfFileAtPath:(id)arg1;
+ (id)sizeFormattedOfItemAtPath:(id)arg1 error:(id *)arg2;
+ (id)sizeFormattedOfItemAtPath:(id)arg1;
+ (id)sizeOfDirectoryAtPath:(id)arg1 error:(id *)arg2;
+ (id)sizeOfDirectoryAtPath:(id)arg1;
+ (id)sizeOfFileAtPath:(id)arg1 error:(id *)arg2;
+ (id)sizeOfFileAtPath:(id)arg1;
+ (id)sizeOfItemAtPath:(id)arg1 error:(id *)arg2;
+ (id)sizeOfItemAtPath:(id)arg1;
+ (_Bool)isWritableItemAtPath:(id)arg1;
+ (_Bool)isReadableItemAtPath:(id)arg1;
+ (_Bool)isExecutableItemAtPath:(id)arg1;
+ (_Bool)isFileAtPath:(id)arg1 error:(id *)arg2;
+ (_Bool)isFileAtPath:(id)arg1;
+ (_Bool)isDirectoryAtPath:(id)arg1 error:(id *)arg2;
+ (_Bool)isDirectoryAtPath:(id)arg1;
+ (_Bool)isEmptyItemAtPath:(id)arg1 error:(id *)arg2;
+ (_Bool)isEmptyItemAtPath:(id)arg1;
+ (_Bool)isExistsAtPath:(id)arg1;
+ (id)suffixAtPath:(id)arg1;
+ (id)directoryAtPath:(id)arg1;
+ (id)fileNameAtPath:(id)arg1 suffix:(_Bool)arg2;
+ (_Bool)moveItemAtPath:(id)arg1 toPath:(id)arg2 overwrite:(_Bool)arg3 error:(id *)arg4;
+ (_Bool)moveItemAtPath:(id)arg1 toPath:(id)arg2 overwrite:(_Bool)arg3;
+ (_Bool)moveItemAtPath:(id)arg1 toPath:(id)arg2 error:(id *)arg3;
+ (_Bool)moveItemAtPath:(id)arg1 toPath:(id)arg2;
+ (_Bool)copyItemAtPath:(id)arg1 toPath:(id)arg2 overwrite:(_Bool)arg3 error:(id *)arg4;
+ (_Bool)copyItemAtPath:(id)arg1 toPath:(id)arg2 overwrite:(_Bool)arg3;
+ (_Bool)copyItemAtPath:(id)arg1 toPath:(id)arg2 error:(id *)arg3;
+ (_Bool)copyItemAtPath:(id)arg1 toPath:(id)arg2;
+ (_Bool)clearTmpDirectory;
+ (_Bool)clearCachesDirectory;
+ (_Bool)removeItemAtPath:(id)arg1 error:(id *)arg2;
+ (_Bool)removeItemAtPath:(id)arg1;
+ (id)modificationDateOfItemAtPath:(id)arg1 error:(id *)arg2;
+ (id)modificationDateOfItemAtPath:(id)arg1;
+ (id)creationDateOfItemAtPath:(id)arg1 error:(id *)arg2;
+ (id)creationDateOfItemAtPath:(id)arg1;
+ (_Bool)createFileAtPath:(id)arg1 content:(id)arg2 overwrite:(_Bool)arg3 error:(id *)arg4;
+ (_Bool)createFileAtPath:(id)arg1 content:(id)arg2 overwrite:(_Bool)arg3;
+ (_Bool)createFileAtPath:(id)arg1 content:(id)arg2 error:(id *)arg3;
+ (_Bool)createFileAtPath:(id)arg1 content:(id)arg2;
+ (_Bool)createFileAtPath:(id)arg1 overwrite:(_Bool)arg2 error:(id *)arg3;
+ (_Bool)createFileAtPath:(id)arg1 overwrite:(_Bool)arg2;
+ (_Bool)createFileAtPath:(id)arg1 error:(id *)arg2;
+ (_Bool)createFileAtPath:(id)arg1;
+ (_Bool)createDirectoryAtPath:(id)arg1 error:(id *)arg2;
+ (_Bool)createDirectoryAtPath:(id)arg1;
+ (id)attributesOfItemAtPath:(id)arg1 error:(id *)arg2;
+ (id)attributesOfItemAtPath:(id)arg1;
+ (id)attributeOfItemAtPath:(id)arg1 forKey:(id)arg2 error:(id *)arg3;
+ (id)attributeOfItemAtPath:(id)arg1 forKey:(id)arg2;
+ (id)listFilesInCachesDirectoryByDeep:(_Bool)arg1;
+ (id)listFilesInTmpDirectoryByDeep:(_Bool)arg1;
+ (id)listFilesInDocumentDirectoryByDeep:(_Bool)arg1;
+ (id)listFilesInLibraryDirectoryByDeep:(_Bool)arg1;
+ (id)listFilesInHomeDirectoryByDeep:(_Bool)arg1;
+ (id)listFilesInDirectoryAtPath:(id)arg1 deep:(_Bool)arg2;
+ (id)tmpDir;
+ (id)cachesDir;
+ (id)preferencesDir;
+ (id)libraryDir;
+ (id)documentsDir;
+ (id)homeDir;
@end
