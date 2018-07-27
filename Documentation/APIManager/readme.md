# XZKit/Networking

## 目的

为 App 的网络层提供一个基本的规范，而不是限制网络层的设计，并在此基础上提供一些基本常用功能。

## 特性

### 1. 规范

框架所有功能，都是通过协议而非具体的类型来实现，方便开发自定义以及个性化管理。

### 2. 并发策略

为常用的接口请求逻辑制定了不同的并发策略，并且仅仅需要一个属性就可以控制。

### 3. 自动重试

加入的自动重试的逻辑，也仅仅需要一个属性就可以控制。

### 4. 异步

接口所有操作都是在子线程中处理的，提高主线程性能。


## 使用说明

推荐使用“分散+集约”方式来设计网络层：分散型和集约型网络层架构的优缺点在此不多述，本框架也都适合这两种架构，但是提倡将两者结合起来设计网络层架构，扬长避短，发挥这两种架构的优点。例如购物车增删改查，如果服务器端提供了多个接口，那么你可以同集约型的架构，将它们合并在一起；而用户相关接口与购物车没有明显关联，那么这两个接口就使用分散型的架构。

### 1. 定义接口

可以使用多种方式来定义你的接口，例如使用集约型架构设计一个接口，你可以使用枚举：

```swift
enum CartAPIRequest: APIRequest {
    case detail(timeInterval: TimeInterval)
    case add(id: String)
    case update(id: String, count: Int)
    case delete(id: String)
    
    var url: URL {
        switch self {
        case .detail: return URL.init(string: "https://api.host.com/cart/detail")!
        case .add:    return URL.init(string: "https://api.host.com/cart/add")!
        case .update: return URL.init(string: "https://api.host.com/cart/update")!
        case .delete: return URL.init(string: "https://api.host.com/cart/delete")!
        }
    }
    
    var method: APIMethod { ... }
    
    var data: Any? { ... }
}
```

也可以使用结构体来设计你的接口：

```swift
struct WeatherAPIRequest: APIRequest {

    let url: URL = URL.init(string: "https://api.seniverse.com/v3/weather/now.json")!
    
    var data: Any? {
        return [
            "key": "z3plmlbgvez2ab2w",
            "language": "zh-Hans",
            "unit": "c",
            "location": city
        ]
    }

    let city: String;

    init(city: String = "beijing") {
        self.city = city;
    }

}
```

甚至你也可以通过类来实现，或者其它方式，APIRequest只规定了基本的接口特征，而非限定具体实现方式。


### 2. 数据解析

框架在三个地方提供了开发者校验或解析数据的机会：请求到原始数据、得到原始数据、构造数据模型。

```swift
struct WeatherAPIResponse: APIResponse {
    
    typealias Request = WeatherAPIRequest

    let date: String
    let weather: (id: String, text: String, temperature: String)
    let location: (id: String, name: String)

    init(request: WeatherAPIRequest, data: Any?) throws {
        guard let result = (data as? [[String : Any]])?.first else { throw APIError.unexpectedResponse }

        guard let date = result["last_update"] as? String else { throw APIError.unexpectedResponse }
        
        guard let weatherDict = result["now"] as? [String: Any] else { throw APIError.unexpectedResponse }
        guard let weatherID = weatherDict["code"] as? String else { throw APIError.unexpectedResponse }
        guard let weatherText = weatherDict["text"] as? String else { throw APIError.unexpectedResponse }
        guard let weatherTemperature = weatherDict["temperature"] as? String else { throw APIError.unexpectedResponse }
        
        guard let locationDict = result["location"] as? [String: Any] else { throw APIError.unexpectedResponse }
        guard let locationID = locationDict["id"] as? String else { throw APIError.unexpectedResponse }
        guard let locationName = locationDict["name"] as? String else { throw APIError.unexpectedResponse }
        
        self.date = date
        self.weather = (weatherID, weatherText, weatherTemperature)
        self.location = (locationID, locationName)
    }

}
```

### 3. 事件转发

所有接口请求的逻辑都是由APIManager调度处理的，而且是默认实现的，你需要做的仅仅是把事件转发给需要的地方。

#### 3.1 定义代理协议

代理协议并不是必须的，因为有些请求可能不需要处理，所以这个框架没有做任何要求。

```swift
protocol WeatherAPIManagerDelegate: NSObjectProtocol  {

    func apiManager(_ apiManager: WeatherAPIManager, request: WeatherAPIRequest, didFailWith error: Error);
    func apiManager(_ apiManager: WeatherAPIManager, request: WeatherAPIRequest, didFinishWith apiResponse: WeatherAPIResponse);

}
```

#### 3.2 定义APIManger

具体代码请看Demo。

```swift
class WeatherAPIManager: APIManager {

    typealias Request   = WeatherAPIRequest
    typealias Response  = WeatherAPIResponse

    weak var delegate: WeatherAPIManagerDelegate?

    ...
}
```

## 技巧

其实也算不上技巧，就是运用Swift语言的特性，为协议提供默认实现来处理一些公共的逻辑。例如框架本身不处理网络请求，但是在每个接口中重写一半网络请求的方法显然是愚蠢的。这个时候，使用协议的默认实现就好了，而且框架的协议提供的功能也是通过默认实现提供的。

```swift
import XZKit
import AFNetworking

extension APINetworking {
    
    public func dataTask(for apiRequest: APIRequest, progress: @escaping ProgressHandler, completion: @escaping CompletionHandler) throws -> URLSessionDataTask? {
        let manager = AFHTTPSessionManager.init()
        
        ....
        
        manager.completionQueue = DispatchQueue.global(qos: .background)
        
        switch apiRequest.method {
        case .GET: ...
        case .POST: ...
        default: ...
        }
        
        throw APIError.invalidRequest
    }
    
}
```


## 作者

mlibai, mlibai@163.com

## 授权

XZKit is available under the MIT license. See the LICENSE file for more info.
