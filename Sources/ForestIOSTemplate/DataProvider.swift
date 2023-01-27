//
//  File.swift
//  
//
//  Created by 염태규 on 2023/01/27.
//

import Foundation

public class DataProvider {
    
    static let shared = DataProvider()
    private init() {}
    
    var views: [String: [BaseView]] = [:]
    
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
    
    public func inflate<T: NCodable>(data: T?) {
        if let data = data {
            views[T.id]?.forEach {
                if let nview = $0 as? BaseNView<T> {
                    nview.inflate(data: data)
                }
            }
        }
    }
    
    public func inflate<T: NCodable>(datas: [T]) {
        views[T.id]?.forEach {
            if let nview = $0 as? BaseNView<T> {
                nview.inflate(datas: datas)
            }
        }
    }
}
