//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UIImage.h"

@interface UIImage (Fix)
+ (struct CGImage *)gradientMask;
- (id)maskImageFromImageAlpha;
- (id)imageWithMask:(id)arg1;
- (id)imageWithAlpha:(double)arg1;
- (id)imageWithCornerRadius:(double)arg1;
- (id)imageWithShadowColor:(id)arg1 offset:(struct CGSize)arg2 blur:(double)arg3;
- (id)imageWithReflectionWithScale:(double)arg1 gap:(double)arg2 alpha:(double)arg3;
- (id)reflectedImageWithScale:(double)arg1;
- (id)imageCroppedAndScaledToSize:(struct CGSize)arg1 contentMode:(long long)arg2 padToFit:(_Bool)arg3;
- (id)imageScaledToFillSize:(struct CGSize)arg1;
- (id)imageScaledToFitSize:(struct CGSize)arg1;
- (id)imageScaledToSize:(struct CGSize)arg1;
- (id)imageCroppedToRect:(struct CGRect)arg1;
@end
