//
//  ObjectiveC.h
//  XZKit
//
//  Created by mlibai on 2018/4/14.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ObjectiveC;

NS_ASSUME_NONNULL_BEGIN

/// com.mlibai.XZKit
UIKIT_EXTERN NSString * const XZKitDomain NS_SWIFT_NAME(Domain);

/// 类禁止继承。
#define XZ_SUBCLASSING_RESTRICTED __attribute__((objc_subclassing_restricted))
/// 重定义类在运行时的名称。
#define XZ_RUNTIME_NAME(runtimeName) __attribute__((objc_runtime_name(runtimeName)))
/// 结构体可以用语法糖包裹成 NSValue 对象。
#define XZ_BOXABLE __attribute__((objc_boxable))

/// 定义一个构造函数，在 main 函数执行前运行。
#define XZ_CONSTRUCTOR __attribute__((constructor))
/// 定义一个构造函数，在 main 函数执行前运行，按优先级数字值从小到大依次执行。
#define XZ_CONSTRUCTOR_WITH_PRIORITY(priorityNumber) __attribute__((constructor(priorityNumber)))

/// 定义一个析构函数，在 main 函数执行后运行。
#define XZ_DESTRUCTOR __attribute__((constructor))
/// 定义一个析构函数，在 main 函数执行后运行，按优先级数字值从小到大依次执行。
#define XZ_DESTRUCTOR_WITH_PRIORITY(priorityNumber) __attribute__((constructor(priorityNumber)))

/// 编译器函数参数检查。
#define XZ_FUNCTION_PARAMETER_ASSERT(condition, message) __attribute__((enable_if(condition, message)))

/// 函数重载。
#define XZ_FUNCTION_OVERLOADABLE __attribute__((overloadable))

/// 变量观察者，当变量结束生命周期时，将自动执行指定的函数。
/// @code
/// void observer(Int anInt) { printf("%d", anInt); }
/// Int someInt XZ_VARIABLE_OBSERVER(observer) = 0;
/// @endcode
#define XZ_VARIABLE_OBSERVER(anObserver) __attribute__((cleanup(anObserver)))

/// defer 闭包的执行函数，请不要直接调用此函数。
///
/// @param operation 待执行的清理操作。
FOUNDATION_STATIC_INLINE void __defer__(void (^ _Nonnull * _Nonnull operation)(void)) NS_SWIFT_UNAVAILABLE("Use Swift.defer instead.") {
    (*operation)();
}

/// 定义当前作用域结束时需执行清理操作。
/// - Note: 仅为 defer 宏提供自动补全的功能，并无实际用途。
///
/// @param operation 待执行的代码块。
FOUNDATION_STATIC_INLINE void defer(void (^ _Nonnull operation)(void)) NS_SWIFT_UNAVAILABLE("Use Swift.defer instead.") {
    operation();
}

#undef defer
/// 定义当前作用域结束时需执行清理操作。
#define defer(statements) void(^__defer)(void) __attribute__((cleanup(__defer__), unused)) = statements



/// 标识 XZKit 是否为 DEBUG 模式。
///
/// @return YES or NO.
UIKIT_EXTERN BOOL XZKitDebugMode(void) NS_SWIFT_UNAVAILABLE("Use XZKit.isDebugMode instead.");


/// 将指定类的 方法1 与 方法2 的方法体互换。
/// @note 如果 方法1 不存在（包括继承自父类但是没有重写的方法），则给类增加一个与方法2相同方法体的方法。
///
/// @param aClass 需要替换方法体的类。
/// @param selector1 待交换方法体的方法。
/// @param selector2 被交换方法体的方法。
UIKIT_EXTERN void xz_objc_class_exchangeMethodImplementations(Class _Nonnull aClass, SEL _Nonnull selector1, SEL _Nonnull selector2) NS_SWIFT_NAME(objc_class_exchangeMethodImplementations(_:_:_:));

/// 获取当前时间戳，精确到微秒。
/// @note 在 Swift 中，请使用 `TimeInterval.since1970` 代替。
///
/// @return 单位为秒，小数点后为微秒。
FOUNDATION_EXTERN NSTimeInterval xz_timestamp(void) NS_REFINED_FOR_SWIFT;

/// 输出信息到控制台，末尾自动换行。不附加任何其它信息。
///
/// @param format 输出格式。
/// @param ...    参数列表。
FOUNDATION_EXTERN void xz_print(NSString * _Nonnull format, ...) NS_FORMAT_FUNCTION(1, 2) NS_NO_TAIL_CALL NS_SWIFT_UNAVAILABLE("Use Swift.print instead.");

/// 输出信息到控制台，末尾自动换行。不附加任何其它信息。
///
/// @param format 输出格式。
/// @param args   参数列表指针。
FOUNDATION_EXTERN void xz_print_v(NSString * _Nonnull format, va_list _Nonnull args) NS_FORMAT_FUNCTION(1, 0) NS_NO_TAIL_CALL NS_SWIFT_UNAVAILABLE("Use Swift.print instead.");

/// 仅在 XZKitDEBUG 模式下，才在控制台输出指定信息。
/// @note 配置 DEBUG 模式：Edit Scheme -> Arguments Passed On Launch -> 添加 **-XZKitDEBUG** 启动参数。
/// @note 此函数为声明，实际使用的为 XZLogv 函数。
///
/// @param format 输出格式。
/// @param ...    参数列表。
FOUNDATION_STATIC_INLINE
void XZLog(NSString * const _Nonnull format, ...) NS_SWIFT_UNAVAILABLE("Use Swift XZKit.XZLog instead.") { }

/// 仅在 XZKitDEBUG 模式下，才在控制台输出指定信息，XZLog 的 verbose 模式。
/// @note 配置 DEBUG 模式：Edit Scheme -> Arguments Passed On Launch -> 添加 **-XZKitDEBUG** 启动参数。
/// @note 请使用宏定义 XZLog ，其该函数会编译到正式代码中。
/// @note 该函数与 Swift 版本实现方式不同。
///
/// @param filePath __FILE__
/// @param line     __LINE__
/// @param function __func__
/// @param format   输出格式。
/// @param ...      参数列表。
FOUNDATION_EXTERN void XZLogv(const char * const filePath, int const line, const char * const function, NSString * const _Nonnull format, ...) NS_FORMAT_FUNCTION(4, 5) NS_SWIFT_UNAVAILABLE("Use Swift XZKit.XZLog instead.");

/// XZLog 原型只起注释的作用。实际执行的是 XZLogv 函数。
#undef XZLog
/// 仅在 XZKitDebug 模式下才在控制台输出。
/// @param format 输出格式。
/// @param ...    参数列表。
#define XZLog(format, ...) XZLogv(__FILE__, (int)__LINE__, __func__, format, ##__VA_ARGS__)


/// 遍历类实例对象的变量。
///
/// @param aClass 类。
/// @param block 遍历所用的 block 。
FOUNDATION_EXTERN void xz_objc_enumerateInstanceVariables(Class aClass, void (^block)(Ivar ivar)) NS_SWIFT_NAME(objc_enumerateInstanceVariables(_:_:));

/// 获取类实例对象的变量名。
///
/// @param aClass 类。
FOUNDATION_EXTERN NSArray<NSString *> * _Nullable xz_objc_getInstanceVariableNames(Class aClass) NS_SWIFT_NAME(objc_getInstanceVariableNames(_:));

/// 遍历类实例对象的方法，不包括父类的方法。
///
/// @param aClass 类。
/// @param block 遍历所用的 block 。
FOUNDATION_EXTERN void xz_objc_enumerateInstanceMethods(Class aClass, void (^block)(Method method)) NS_SWIFT_NAME(objc_enumerateInstanceMethods(_:_:));

/// 获取类实例对象的方法名。
///
/// @param aClass 类。
FOUNDATION_EXTERN NSArray<NSString *> * _Nullable xz_objc_getInstanceMethodSelectors(Class aClass) NS_SWIFT_NAME(objc_getInstanceMethodSelectors(_:));


NS_ASSUME_NONNULL_END


