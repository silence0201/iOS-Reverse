//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "SKPaymentTransactionObserver.h"
#import "SKProductsRequestDelegate.h"

@class NSMutableArray, NSMutableDictionary, NSString;

@interface SIIAppPurchaseManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    _Bool _purchasedItemsChanged;
    NSMutableArray *_purchasedItems;
    NSMutableDictionary *_products;
    NSMutableArray *_productRequests;
    NSMutableArray *_payments;
    NSMutableArray *_purchasesChangedCallbacks;
    CDUnknownBlockType _restoreCompletionBlock;
    CDUnknownBlockType _restoreErrorBlock;
}

+ (id)sharedManager;
@property(copy) CDUnknownBlockType restoreErrorBlock; // @synthesize restoreErrorBlock=_restoreErrorBlock;
@property(copy) CDUnknownBlockType restoreCompletionBlock; // @synthesize restoreCompletionBlock=_restoreCompletionBlock;
@property(retain) NSMutableArray *purchasesChangedCallbacks; // @synthesize purchasesChangedCallbacks=_purchasesChangedCallbacks;
@property(retain) NSMutableArray *payments; // @synthesize payments=_payments;
@property(retain) NSMutableArray *productRequests; // @synthesize productRequests=_productRequests;
@property _Bool purchasedItemsChanged; // @synthesize purchasedItemsChanged=_purchasedItemsChanged;
@property(retain) NSMutableDictionary *products; // @synthesize products=_products;
@property(retain) NSMutableArray *purchasedItems; // @synthesize purchasedItems=_purchasedItems;
- (void).cxx_destruct;
- (void)paymentQueueRestoreCompletedTransactionsFinished:(id)arg1;
- (void)paymentQueue:(id)arg1 restoreCompletedTransactionsFailedWithError:(id)arg2;
- (void)removePurchasesChangedCallbackWithContext:(id)arg1;
- (void)addPurchasesChangedCallback:(CDUnknownBlockType)arg1 withContext:(id)arg2;
- (_Bool)canPurchase;
- (void)paymentQueue:(id)arg1 updatedTransactions:(id)arg2;
- (void)purchaseProductForId:(id)arg1 completion:(CDUnknownBlockType)arg2 error:(CDUnknownBlockType)arg3;
- (void)purchaseProduct:(id)arg1 completion:(CDUnknownBlockType)arg2 error:(CDUnknownBlockType)arg3;
- (void)restorePurchasesWithCompletion:(CDUnknownBlockType)arg1 error:(CDUnknownBlockType)arg2;
- (void)restorePurchasesWithCompletion:(CDUnknownBlockType)arg1;
- (void)restorePurchases;
- (void)request:(id)arg1 didFailWithError:(id)arg2;
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2;
- (void)getProductsForIds:(id)arg1 completion:(CDUnknownBlockType)arg2 error:(CDUnknownBlockType)arg3;
- (_Bool)hasPurchased:(id)arg1;
- (void)willResignActive:(id)arg1;
- (void)persistPurchasedItems;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
