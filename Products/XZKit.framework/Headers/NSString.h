//
//  NSString.h
//  XZKit
//
//  Created by mlibai on 2018/7/25.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 字符串字符大小写样式。
typedef NSString * XZCharacterCase NS_STRING_ENUM NS_SWIFT_NAME(CharacterCase);

/// 字符串字母大写，原始值为 @"%02X" 。
FOUNDATION_EXTERN XZCharacterCase const _Nonnull XZCharacterUpperCase NS_SWIFT_NAME(uppercase);
/// 字符串字母小写，原始值为 @"%02x" 。
FOUNDATION_EXTERN XZCharacterCase const _Nonnull XZCharacterLowerCase NS_SWIFT_NAME(lowercase);

@interface NSString (XZKit)

@end
