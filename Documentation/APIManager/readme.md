# XZKit/APIManager

[![CI Status](https://img.shields.io/travis/rust-lang/rust.svg)](https://cocoapods.org/mlibai/XZKit)
[![Version](https://img.shields.io/badge/Version-2.0.22-blue.svg?style=flat)](http://cocoapods.org/pods/XZKit)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](http://cocoapods.org/pods/XZKit)
[![Platform](https://img.shields.io/badge/Platform-iOS-yellow.svg)](http://cocoapods.org/pods/XZKit)

## 环境

Swift 4.0

## 安装

建议使用 [CocoaPods](http://cocoapods.org). 安装:

```ruby
pod "XZKit"
```

## 特性

### 1. 分散型的API管理框架

通过协议而非基类，为管理网络API的一些基础逻辑提供了默认实现，方便每个接口自定义以及个性化管理。

### 2. 并发策略：APIConcurrencyPolicy

在实际业务中，同一个接口，其请求之间可能有依赖关系。比如购物车，对购物车的增删改查，为了避免显示错误，就可能需要按顺序请求；再如获取商品详情，如果同时发送了多个请求，因为连接数的限制，却希望优先执行最后发起的请求。对于这些基本逻辑，现在通过APIConcurrencyPolicy策略，仅仅设置请求的属性，就可以轻松实现了。

```swift
public enum APIConcurrencyPolicy {
    case `default`;
    case cancelOthers;
    case waitUntilDone;
    case waitUntilDoneHighPriority;
    case ignoreCurrent;
}
public protocol APIRequest {
    ...
    var concurrencyPolicy: APIConcurrencyPolicy { get };
    ...
}
```

### 2. 自动重试：APIRequest.retryIfFailed

在某些情况下，如果网络请求失败，却希望请求能自动重新请求时，现在仅需求设置一个属性就可以实现了。

```swift
public protocol APIManager {
    ...
    func task(_ apiTask: TaskType, delayIntervalForRetryAt index: UInt) -> TimeInterval?;
    ...
}

/// API 定义了接口特征，如请求参数、缓存策略等。
public protocol APIRequest {
    ...
    var retryIfFailed: Bool { get };
    ...
}

```

## 使用说明

### 1. 定义 APIRequest

`APIRequest` 协议定义了接口所必须的参数必须的属性，描述了接口请求所需的参数。借助于 Swift 的特性，实现 `APIRequest` 协议不必实现其所有属性或方法。例如全部使用默认值的情况下，你只需要给出 API 的 `url` 属性即可。

```swift
struct SampleAPIRequest: APIRequest {
    let url: URL = URL(string: "https://your.api.url")!;
}
```

### 2. 定义 APIResponse

`APIResponse` 统一接口返回数据的基本格式，以及数据的初步验证和解析。

```swift
struct SampleAPIResponse: APIResponse {

    typealias Result = [String : Any]
    
    var result: [String : Any]!
    
    required init(code: Int, message: String, result: Any?) throws {
        guard code == noErr else {
            /// 所有接口逻辑错误，都转换成异常抛出。
            throw APIError.init(code: code, message: message)
        }
        guard let result = result as? [[String : Any]] else { throw APIError.unexpectedResponse }
        guard result.count > 0 else { throw APIError.unexpectedResponse }
        self.result = result[0]
    }
}
```

### 3. APIManager

定义了接口和数据，那么它们是如何关联起来，又是如何发送给需要使用的地方的呢，这正是 `APIManager` 协议负责的事情。在实现该协议的过程中，要做的就两件事：关联已定义的接口和数据、转发结果。`APIManager` 同时也管理着接口的请求，如并发、自动重试，但是这些是它已经具备的功能，除非你想自定义这些繁琐的过程，否则你无需额外的去实现它们。

```swift
class SampleAPIManager: APIManager {
    typealias Request   = SampleAPIRequest
    typealias Response  = SampleAPIResponse
    typealias Delegate  = APIManagerDelegate
}
```

### 4. 自定义

通过上面三步，就可以实现一个简单的接口请求。当你使用它时，应该是这一个样子：

```swift
class SampleViewController: UIViewController, APIManagerDelegate {

    var sampleAPIManager: SampleAPIManager = SampleAPIManager.init();

    override func viewDidLoad() {
        super.viewDidLoad()

        sampleAPIManager.delegate = self;
        let request = SampleAPIRequest.init();
        _ = sampleAPIManager.send(request);
    }

    func apiManager(_ apiManager: AnyAPIManager, task apiTask: AnyAPITask, didFinishWith apiResponse: AnyAPIResponse) {
        guard let response = apiResponse as? APIResponse<SampleAPIResponseResult> else { return; }
        print(response.result.data);
    }
}
```

因这里涉及的逻辑都简化处理了，代码量并不多。但是里面至少有一点不是我们所期望的：类型转换。Swift 语言是类型安全语言，在使用的时候去类型转换肯定是一件头疼的事情，特别是当使用多个 API 时，判断 APIResponse 类型就需要写一大段代码，所以我们需要自定义。

#### 4.1 自定代理协议

你可以完全自定义全部代理方法，但是这可能会增加你的工作量。推荐的做法是，定义一个继承自 `APIManagerDelegate` 的协议，这样你即可以使用默认方法，也可以添加自定义方法。

```swift
protocol SampleAPIManagerDelegate: APIManagerDelegate  {
    
    func apiManager(_ apiManager: SampleAPIManager, task apiTask: APITask<SampleAPIRequest>, didFailWith error: Error);
    func apiManager(_ apiManager: SampleAPIManager, task apiTask: APITask<SampleAPIRequest>, didFinishWith apiResponse: SampleAPIResponse);
    
}
```

那么在 `APIManger` 应该就是这样：

```swift
class SampleAPIManager: APIManager {
    ...
    typealias Delegate = SampleAPIManagerDelegate;
    ...
    /// 将事件转发至自定的代理协议方法上。
    func task(_ apiTask: APITask<SampleAPIRequest>, didFailWith error: Error) {
        delegate?.apiManager(self, task: apiTask, didFailWith: error);
    }

    func task(_ apiTask: APITask<SampleAPIRequest>, didFinishWith apiResponse: SampleAPIResponse) {
        delegate?.apiManager(self, task: apiTask, didFinishWith: apiResponse)
    }
    
}
```

控制器自然也就是这样了：

```swift
class SampleViewController: UIViewController {

    func apiManager(_ apiManager: SampleAPIManager, task apiTask: APITask<SampleAPIRequest>, didFinishWith apiResponse: SampleAPIResponse) {
         print("\(apiTask.request.city) 天气信息：\(apiResponse.result)")
    }

}
```

现在，在控制器中，你就可以直接得到自定义类型的 `SampleAPIResponse` 。在实际业务中，如果一个控制器需要用到多个 API ，通过自定义，每个 API 的返回结果都可以转发到不同的方法上，有效避免在同一个方法中处理所有 API 带来的麻烦。

#### 4.2 深度自定义

上面的自定义成功解决了类型转换的问题，但是设计者考虑的更多，比如为了方便自定请求，将 `APIRequest` 独立出来。


## 全局

### 1. 统一网络请求方式

为了与已有的网络请求方式一致，在 `APIManager` 中，只有发送网络请求的方法没有提供默认实现。开发者可通过 `extension` 为 `APIManager` 添加该方法的默认实现，以避免重复的操作。比如，在使用 `AFNetworking` 的情况下：

```swift
import XZKit
import AFNetworking

extension APIManager {
    
    /// 使用 AFNetworking 来处理网络请求。
    func dataTask(with apiRequest: Request, progress: @escaping (_ percent: Double)-> Void, success: @escaping (_ responseObject: Any?) -> Void, failure: @escaping (_ error: Error) -> Void) throws -> URLSessionDataTask? {
        let manager = AFHTTPSessionManager.init()
        
        if let headers = apiRequest.headers {
            for item in headers {
                manager.requestSerializer.setValue(item.value, forHTTPHeaderField: item.key)
            }
        }
        
        manager.requestSerializer.cachePolicy = apiRequest.cachePolicy
        manager.requestSerializer.timeoutInterval = apiRequest.timeoutInterval
        
        let urlString = apiRequest.url.absoluteString
        let data = apiRequest.data
        
        let progressHandler = { (_ progressObject: Progress) in
            progress(Double(progressObject.completedUnitCount)/Double(progressObject.totalUnitCount))
        }
        
        let successHandler = { (_ task: URLSessionDataTask, _ responseObject: Any?) in
            success(responseObject)
        }
        
        let failureHandler = { (_ task: URLSessionDataTask?, _ error: Error) in
            failure(error)
        }
        
        switch apiRequest.method {
        case .GET:
            return manager.get(urlString, parameters: data, progress: progressHandler, success: successHandler, failure: failureHandler)
        case .POST:
            return manager.post(urlString, parameters: data, progress: progressHandler, success: successHandler, failure: failureHandler)
        default: break
        }
        

        throw APIError.unreachable
    }
    
    /// 统一的接口数据验证方式。
    func task(_ apiTask: APITask<Request>, didReceive responseObject: Any?) throws -> Response {
        // 验证数据为字典（验证数据过程，开发者应该根据实际情况进行）。
        guard let dict = responseObject as? [String: Any]   else { throw APIError.unexpectedResponse }
        // 字典必须包含 code 键（验证数据过程，开发者应该根据实际情况进行）。
        guard let code = dict["code"] as? Int               else { throw APIError.unexpectedResponse }
        // 字典必须包含 message 键（验证数据过程，开发者应该根据实际情况进行）。
        guard let message = dict["message"] as? String      else { throw APIError.unexpectedResponse }
        // 生成 Response 。
        return try Response.init(code: code, message: message, result: dict["results"])
    }
    
}
```

### 2. 默认代理

推荐使用 `APIMangerDelegate` 协议作为所有 `APIManager` 代理的的基协议。为了避免在业务逻辑中去实现 `APIMangerDelegate` 中的方法，也可以通过 `extension` 为它添加默认实现来解决。例如在默认实现中做一些 `DEBUG` 打印操作。

```swift
extension APIManagerDelegate {
    
    func apiManager(_ apiManager: AnyAPIManager, task apiTask: AnyAPITask, didFailWith error: Error) {
        #if DEBUG
            print("接口请求发生错误：\nAPIManager: \(type(of: apiManager)) \nError: \(error)");
        #endif
    }
    
}
```



## 作者

mlibai, mlibai@163.com

## 授权

XZKit is available under the MIT license. See the LICENSE file for more info.
