//
//  UIImage.h
//  XZKit
//
//  Created by mlibai on 2017/10/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XZKit)

/// 读取 XZKit 中的资源库图片。
///
/// @param name 图片名字
/// @param traitCollection UITraitCollection
/// @return UIImage
+ (nullable UIImage *)XZKit:(NSString *)name compatibleWithTraitCollection:(nullable UITraitCollection *)traitCollection NS_SWIFT_NAME(init(XZKit:compatibleWith:));

/// 读取 XZKit 中的资源库图片。
///
/// @param name 图片名称
/// @return UIImage
+ (nullable UIImage *)XZKit:(NSString *)name NS_SWIFT_NAME(init(XZKit:));

@end


@interface UIImage (XZKitDrawing)

/// 根据指定条件绘制图片。
/// @note 该方法绘制的图片不会被缓存。
///
/// @param fillColor 填充颜色。
/// @param borderColor 边线颜色。
/// @param borderWidth 边线粗细。
/// @param cornerRadius 圆角大小。
/// @param roundCorners 圆角数。
/// @param imageSize 图片大小。
/// @return 绘制的图片。
+ (nullable UIImage *)xz_imageWithFillColor:(nullable UIColor *)fillColor borderColor:(nullable UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius roundCorners:(UIRectCorner)roundCorners size:(CGSize)imageSize NS_SWIFT_NAME(init(fillColor:borderColor:borderWidth:cornerRadius:roundCorners:size:));

@end


@interface UIImage (XZKitBlending)

/// 混合。改变图片透明度。
///
/// @param alpha 透明度
/// @return UIImage
- (nullable UIImage *)xz_imageWithBlendingAlpha:(CGFloat)alpha NS_SWIFT_NAME(blending(_:));

/// 混合，重新渲染图片颜色。
///
/// @param tintColor 图片渲染色。
/// @return 渲染后的图片。
- (nullable UIImage *)xz_imageWithBlendingColor:(UIColor *)tintColor NS_SWIFT_NAME(blending(_:));

@end


/// 色阶，用于表示图片色彩分布的值。
typedef struct {
    /// 色阶阴影，范围 0 ~ 1.0 ，默认 0 。
    CGFloat min;
    /// 色阶亮度，范围 0 ~ 1.0 ，默认 1.0 。
    CGFloat max;
    /// 色阶中间值，范围 0 ~ 9.99 ，默认 1.0 。
    CGFloat mid;
} XZColorLevels NS_SWIFT_NAME(ColorLevels);

/// 构造色阶。
///
/// @param min 色阶阴影，0 ~ 1.0。
/// @param max 色阶亮度，0 ~ 1.0。
/// @param mid 色阶中间值，0 ~ 9.99。
/// @return 色阶。
UIKIT_STATIC_INLINE XZColorLevels XZColorLevelsMake(CGFloat min, CGFloat max, CGFloat mid) {
    XZColorLevels levels; levels.min = min; levels.max = max; levels.mid = mid; return levels;
}

/// 判断色阶是否相等。
UIKIT_STATIC_INLINE BOOL XZColorLevelsEqualToLevels(XZColorLevels levels1, XZColorLevels levels2) {
    return (levels1.min == levels2.min && levels1.max == levels2.max && levels1.mid == levels2.mid);
}

/// The identity color levles, which min = 0, max = 1.0, mid = 1.0 .
UIKIT_EXTERN XZColorLevels const XZColorLevelsIdentity NS_SWIFT_NAME(ColorLevels.identity);


@interface UIImage (XZKitFiltering)

/// 滤镜。改变图片亮度。
/// @note 图片处理属于高耗性能的操作。
///
/// @param brightness 图片亮度，0 为正常，-1.0 为最暗，1.0 为最亮。
/// @return UIImage
- (nullable UIImage *)xz_imageWithFilteringBrightness:(CGFloat)brightness NS_SWIFT_NAME(filtering(_:));

/// 滤镜。改变图片色阶。
/// @note 图片处理属于高耗性能的操作。
///
/// @param colorLevels 色阶。
/// @return UIImage
- (nullable UIImage *)xz_imageWithFilteringColorLevels:(XZColorLevels)colorLevels NS_SWIFT_NAME(filtering(_:));

@end

NS_ASSUME_NONNULL_END
