//
//  File.swift
//  
//
//  Created by 염태규 on 2023/01/27.
//

import Foundation
import UIKit
import Alamofire

public struct ApiResult {
    public let modelId: String
    public let request: ApiRequest
    public let result: NCodable?
}

public struct ApiResults {
    public let modelId: String
    public let request: ApiRequest
    public let results: [NCodable]?
}

public protocol ApiRequest {
    var method: HTTPMethod { get set }
    var url: String { get set }
    var encoding: ParameterEncoding? { get set }
    var parameters: [String: Any] { get set }
    var pathes: [CVarArg] { get set }
    
    var end: String { get }
    var id: String { get }
    var defaultEncoding: ParameterEncoding { get }
    func get<T: NCodable>(type: T.Type) async -> ApiResult?
    func gets<T: NCodable>(type: T.Type, isAdd: Bool) async -> ApiResults?
}

public actor DataProvider { // only for get!
    
    public static let shared = DataProvider()
    private init() {}
    
    var resultDict: [String: ApiResult] = [:]
    var resultsDict: [String: ApiResults] = [:]
    var views: [String: [BaseView]] = [:]
    var lastLoadedTimes: [String: Double] = [:]
    
    public func register<T: NCodable>(view: BaseNView<T>) -> (String) -> Void {
        if views[T.id] == nil {
            views[T.id] = []
        }
        views[T.id]?.append(view)
        let unregister: (String) -> Void = { uuid in
            self.views[T.id]?.removeAll(where: { (($0 as? BaseNView<T>)?.id ?? "") == uuid })
        }
        return unregister
    }
    
    func checkTime(id: String) -> Bool {
        if let lastTime = lastLoadedTimes[id] {
            if Date().timeIntervalSince1970 - lastTime < 1 {
                return false
            } else {
                lastLoadedTimes[id] = Date().timeIntervalSince1970
            }
        } else {
            lastLoadedTimes[id] = Date().timeIntervalSince1970
        }
        return true
    }
    
    public func getFromCache<T: NCodable>(type: T.Type, requestId: String) -> T? {
        return resultDict[requestId]?.result as? T
    }
    
    public func getsFromCache<T: NCodable>(type: T.Type, requestId: String) -> [T]? {
        return resultsDict[requestId]?.results as? [T]
    }
    
    public func request<T: NCodable>(type: T.Type, loadFromCache: Bool = false, request: ApiRequest) async {
        guard checkTime(id: request.id) else { return }
        if !loadFromCache || resultDict[request.id] == nil {
            await startLoading(type: type)
            resultDict[request.id] = await request.get(type: type)
        }
        let value = resultDict[request.id]?.result as? T
        await inflate(data: value)
    }
    
    public func requests<T: NCodable>(type: T.Type, loadFromCache: Bool = false, isAdd: Bool = false, request: ApiRequest) async {
        guard checkTime(id: request.id) else { return }
        if !loadFromCache || resultsDict[request.id] == nil {
            await startLoading(type: type)
            resultsDict[request.id] = await request.gets(type: type, isAdd: isAdd)
        }
        let values = resultsDict[request.id]?.results as? [T]
        await inflate(datas: values)
    }
    
    public func startLoading<T: NCodable>(type: T.Type) async {
        for view in views[T.id] ?? [] {
            if let nview = view as? BaseNView<T> {
                await nview.onShowLoading()
            }
        }
    }
    
    public func inflate<T: NCodable>(data: T?) async {
        if let data = data {
            for view in views[T.id] ?? [] {
                if let nview = view as? BaseNView<T> {
                    DispatchQueue.main.async {
                        nview.inflate(data: data)
                    }
                    await nview.onStopLoading()
                }
            }
        }
    }
    
    public func inflate<T: NCodable>(datas: [T]?) async {
        if let datas = datas {
            for view in views[T.id] ?? [] {
                if let nview = view as? BaseNView<T> {
                    DispatchQueue.main.async {
                        nview.inflate(datas: datas)
                    }
                    await nview.onStopLoading()
                }
            }
        }
    }
}
