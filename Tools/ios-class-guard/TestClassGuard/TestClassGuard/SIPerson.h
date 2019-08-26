//
//  SIPerson.h
//  TestClassGuard
//
//  Created by Silence on 2019/8/26.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIPerson : NSObject

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString *name;

@end

NS_ASSUME_NONNULL_END
