//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "NSURLSessionDataDelegate.h"

@class NSMutableArray, NSOperationQueue, NSString, NSURLSession;

@interface SIDownloadManager : NSObject <NSURLSessionDataDelegate>
{
    _Bool _batching;
    int _maxDownloadingCount;
    NSOperationQueue *_queue;
    NSURLSession *_session;
    NSMutableArray *_downloadInfoArray;
}

+ (void)resumeAll;
+ (void)suspendAll;
+ (void)cancelAll;
+ (id)managerWithIdentifier:(id)arg1;
+ (id)manager;
+ (id)defaultManager;
+ (void)initialize;
@property(nonatomic, getter=isBatching) _Bool batching; // @synthesize batching=_batching;
@property(retain, nonatomic) NSMutableArray *downloadInfoArray; // @synthesize downloadInfoArray=_downloadInfoArray;
@property(retain, nonatomic) NSURLSession *session; // @synthesize session=_session;
@property(nonatomic) int maxDownloadingCount; // @synthesize maxDownloadingCount=_maxDownloadingCount;
@property(retain, nonatomic) NSOperationQueue *queue; // @synthesize queue=_queue;
- (void).cxx_destruct;
- (void)URLSession:(id)arg1 task:(id)arg2 didCompleteWithError:(id)arg3;
- (void)URLSession:(id)arg1 dataTask:(id)arg2 didReceiveData:(id)arg3;
- (void)URLSession:(id)arg1 dataTask:(id)arg2 didReceiveResponse:(id)arg3 completionHandler:(CDUnknownBlockType)arg4;
- (id)downloadInfoForURL:(id)arg1;
- (void)resume:(id)arg1;
- (void)suspend:(id)arg1;
- (void)cancel:(id)arg1;
- (void)resumeAll;
- (void)suspendAll;
- (void)cancelAll;
- (void)resumeFirstWillResume;
- (id)download:(id)arg1;
- (id)download:(id)arg1 state:(CDUnknownBlockType)arg2;
- (id)download:(id)arg1 progress:(CDUnknownBlockType)arg2 state:(CDUnknownBlockType)arg3;
- (id)download:(id)arg1 toDestinationPath:(id)arg2 progress:(CDUnknownBlockType)arg3 state:(CDUnknownBlockType)arg4;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
