//
//  MachOSignature.h
//  MachOSignature
//
//  Created by Silence on 2021/2/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
  获取macho文件中的签名证书信息
 */
@interface MachOSignature : NSObject

/**
  获取签名证书信息

 @return  NSdictionary
        key Entitlements 为签名详细信息 ， 为  字符串类型 类型
        key EntitlementsHash 为签名的 sha1 hash值, 为40位的 小写16进制。
        如果没有该两项值， 则返回空，可视为不安全。（模拟器调试状态下，无这两个值，但是一般情况下，肯定会有这两个值的）
 */
+ (NSDictionary *)loadSignature;

@end

NS_ASSUME_NONNULL_END