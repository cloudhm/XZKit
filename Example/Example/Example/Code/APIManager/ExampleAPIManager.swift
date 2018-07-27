//
//  ExampleAPIManager.swift
//  XZKit_Example
//
//  Created by mlibai on 2017/11/28.
//  Copyright © 2017年 mlibai. All rights reserved.
//

import Foundation
import XZKit
import AFNetworking

extension APINetworking {
    
    public func dataTask(for apiRequest: APIRequest, progress: @escaping ProgressHandler, completion: @escaping CompletionHandler) throws -> URLSessionDataTask? {
        let manager = AFHTTPSessionManager.init()
        
        _ = apiRequest.headers?.map({ (item) in
            manager.requestSerializer.setValue(String.init(describing: item.value), forHTTPHeaderField: item.key)
        })
        
        manager.requestSerializer.cachePolicy = apiRequest.cachePolicy
        manager.requestSerializer.timeoutInterval = apiRequest.timeoutInterval
        
        let urlString = apiRequest.url.absoluteString
        let data = apiRequest.data
        
        let progressHandler = { (_ progressObject: Progress) in
            progress(progressObject)
        }
        
        let successHandler = { (_ task: URLSessionDataTask, _ responseObject: Any?) in
            completion(responseObject, nil)
        }
        
        let failureHandler = { (_ task: URLSessionDataTask?, _ error: Error) in
            completion(nil, error)
        }
        
        manager.completionQueue = DispatchQueue.global(qos: .background)
        
        switch apiRequest.method {
        case .GET:
            #if DEBUG
            var url = apiRequest.url;
            if let dict = apiRequest.data as? [String: Any] {
                url.addQueryItems(from: dict)
            }
            let headers = manager.requestSerializer.httpRequestHeaders.map({ (itemClick) -> String in
                return "\(itemClick.key): \(itemClick.value)"
            }).joined(separator: "\n   ")
            XZLog("Method:  GET\nURL:     %@\nHeaders: %@", url.absoluteString, headers)
            #endif
            return manager.get(urlString, parameters: data, progress: progressHandler, success: successHandler, failure: failureHandler)
        case .POST:
            #if DEBUG
            let headers = manager.requestSerializer.httpRequestHeaders.map({ (itemClick) -> String in
                return "\(itemClick.key): \(itemClick.value)"
            }).joined(separator: "\n   ")
            let dataString = (apiRequest.data as? [String: Any])?.map({ (itemClick) -> String in
                if let json = String.init(json: itemClick.value) {
                    return "\(itemClick.key): \(json.replacingOccurrences(of: "\\n", with: ""))"
                }
                return "\(itemClick.key): <非 JSON 数据类型>"
            }).joined(separator: "\n   ")
            let fileString = apiRequest.attachments?.map({ (item) -> String in
                return "\(item.key): \(item.value)"
            }).joined(separator: "\n   ")
            XZLog("Method:  POST\nURL:     %@\nHeaders: %@\nData:    %@\nFile:    %@", urlString, headers, dataString, fileString)
            #endif
            if let attachments = apiRequest.attachments {
                return manager.post(urlString, parameters: data, constructingBodyWith: { (formData) in
                    for attachment in attachments {
                        if let image = attachment.value as? UIImage, let data = UIImagePNGRepresentation(image) {
                            formData.appendPart(withFileData: data, name: attachment.key, fileName: "image", mimeType: "image/png")
                        } else if let data = attachment.value as? Data {
                            formData.appendPart(withForm: data, name: attachment.key)
                        } else if let url = attachment.value as? URL {
                            try? formData.appendPart(withFileURL: url, name: attachment.key)
                        }
                    }
                }, progress: progressHandler, success: successHandler, failure: failureHandler)
            }
            return manager.post(urlString, parameters: data, progress: progressHandler, success: successHandler, failure: failureHandler)
        default: break
        }
        
        throw APIError.invalidRequest
    }
    
}

extension APIManager {
    
    public func request(_ request: Request, didUpdateProgress progress: Foundation.Progress) {
        
    }

    /// 统一的接口数据验证方式。
    public func request(_ request: Request, didReceive responseObject: Any?) throws -> Response {
        
        guard let dict = responseObject as? [String: Any]   else { throw APIError.unexpectedResponse }
        guard let code = dict["code"] as? Int               else { throw APIError.unexpectedResponse }
        guard let message = dict["message"] as? String      else { throw APIError.unexpectedResponse }
        
        guard code == noErr else {
            throw APIError.init(code: code, message: message)
        }
        
        return try Response.init(request: request, data: dict["results"])
    }
    
    public func request(_ request: Request, didFinishWith response: Response) {
        XZLog("Unhandled APIResponse: %@", response)
    }

    public func request(_ request: Request, didFailWithError error: APIError) {
        XZLog("Unhandled APIError: %@", error)
    }

    public func request(_ request: Request, timeIntervalForNextRetry retriedTimes: UInt) -> TimeInterval? {
        switch retriedTimes {
        case 0, 1: return 5.0
        default:
            let time1 = self.request(request, timeIntervalForNextRetry: retriedTimes - 1)!
            let time2 = self.request(request, timeIntervalForNextRetry: retriedTimes - 2)!
            return time1 + time2
        }
    }
    
}

// 1. 定义接口请求参数。
struct ExampleAPIRequest: APIRequest {

    let url: URL = URL.init(string: "https://api.seniverse.com/v3/weather/now.json")!
    
    var data: Any? {
        return [
            "key": "z3plmlbgvez2ab2w",
            "language": "zh-Hans",
            "unit": "c",
            "location": city
        ]
    }

    var retryIfFailed: Bool {
        return false;
    }

    /// 同时只能发送一个请求，新的请求被忽略。
    var concurrencyPolicy: APIConcurrencyPolicy = .ignoreCurrent;

    let city: String;

    init(city: String = "beijing") {
        self.city = city;
    }

}

// 2. 定义解析接口数据的方式。
struct ExampleAPIResponse: APIResponse {
    
    typealias Request = ExampleAPIRequest

    let date: String
    let weather: (id: String, text: String, temperature: String)
    let location: (id: String, name: String)

    init(request: ExampleAPIRequest, data: Any?) throws {
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

/// 3. 自定义代理事件。
protocol ExampleAPIManagerDelegate: NSObjectProtocol  {

    func apiManager(_ apiManager: ExampleAPIManager, request: ExampleAPIRequest, didFailWith error: Error);
    func apiManager(_ apiManager: ExampleAPIManager, request: ExampleAPIRequest, didFinishWith apiResponse: ExampleAPIResponse);

}


// 4. 定义 APIManager
class ExampleAPIManager: APIManager {

    typealias Request   = ExampleAPIRequest
    typealias Response  = ExampleAPIResponse

    weak var delegate: ExampleAPIManagerDelegate?

    // 4.2 自定义接口逻辑。

    func weather(of city: String, policy: APIConcurrencyPolicy) {
        var request = ExampleAPIRequest.init(city: city)
        request.concurrencyPolicy = policy;
        _ = send(request);
    }

    // 4.3 自定义基本数据验证（如果当前接口的数据格式与默认格式不同时）。
    
    func request(_ request: ExampleAPIRequest, didReceive responseObject: Any?) throws -> ExampleAPIResponse {
        guard let data = responseObject as? [String: Any] else { throw APIError.unexpectedResponse }
        return try ExampleAPIResponse.init(request: request, data: data["results"])
    }

    // 4.4 自定义事件转发，未定义的事件将走默认代理方法。
    
    func request(_ request: ExampleAPIRequest, didFailWithError error: Error) {
        DispatchQueue.main.async(execute: {
            self.delegate?.apiManager(self, request: request, didFailWith: error)
        })
    }

    func request(_ request: ExampleAPIRequest, didFinishWith response: ExampleAPIResponse) {
        DispatchQueue.main.async(execute: {
            self.delegate?.apiManager(self, request: request, didFinishWith: response)
        })
    }
    
    deinit {
        XZLog("%@ 已成功销毁！", self)
    }
    
}











