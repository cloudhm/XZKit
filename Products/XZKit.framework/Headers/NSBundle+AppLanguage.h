//
//  NSBundle+AppLanguage.h
//  XZKit
//
//  Created by mlibai on 2018/7/26.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XZKit/NSBundle.h>

/// App 语言。
typedef NSString *XZAppLanguage NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(AppLanguage);

/// 语言设置发生改变。
FOUNDATION_EXTERN NSNotificationName _Nonnull XZAppPreferredLanguagesDidChangeNotification NS_SWIFT_NAME(AppPreferredLanguagesDidChange);
/// 第一偏好语言，与 currentLanguage 相同。
FOUNDATION_EXTERN NSString * _Nonnull const XZAppFirstPreferredLanguageUserInfoKey NS_SWIFT_NAME(AppFirstPreferredLanguageUserInfoKey);
/// 偏好语言列表。
FOUNDATION_EXTERN NSString * _Nonnull const XZAppPreferredLanguagesUserInfoKey NS_SWIFT_NAME(AppPreferredLanguagesUserInfoKey);
/// App 设置语言在 UserDefaults 中使用的键名。
FOUNDATION_EXTERN NSString * _Nonnull const XZAppleLanguagesUserDefaultsKey NS_SWIFT_NAME(AppleLanguagesUserDefaultsKey);

@interface NSBundle (AppLanguage)

/// App 当前语言，如 cn、en、ar 等。
/// @note 设置的语言必须是包所支持的语言。
/// @note 设置语言会将改变当前对象的类型，以启用 App 内容语言切换支持。
/// @note 某些语言的布局方向可能与当前语言不一致，需要开发者自行处理布局方向的问题（iOS 9以后使用 UIView.semanticContentAttribute 属性可以解决大部分布局方向的问题）。
/// @note 在 Swift 中，使用 AppLanguage.current 代替此属性。
@property (nonatomic, nonnull, setter=xz_setCurrentLanguage:) XZAppLanguage xz_currentLanguage NS_REFINED_FOR_SWIFT;

/// 获取指定语言的语言包。
///
/// @param language 语言。
/// @return 语言包。
- (nullable NSBundle *)xz_resourceBundleForLanguage:(nonnull XZAppLanguage)language NS_SWIFT_NAME(resourceBundle(for:));

/// 是否支持 App 内语言切换，默认 NO，该功能会自动打开。
@property (nonatomic, readonly) BOOL xz_supportsInAppLanguageSwitching NS_SWIFT_NAME(supportsInAppLanguageSwitching);


@end

@interface XZBundle (AppLanguage)
- (nonnull NSString *)localizedStringForKey:(nonnull NSString *)key value:(nullable NSString *)value table:(nullable NSString *)tableName;
- (BOOL)xz_supportsInAppLanguageSwitching;
@end

