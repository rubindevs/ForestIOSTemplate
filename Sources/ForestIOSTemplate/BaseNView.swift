//
//  File.swift
//  
//
//  Created by 염태규 on 2023/01/27.
//

import Foundation
import UIKit

open class BaseNView<T: NCodable>: BaseView {
    
    let id = UUID().uuidString
    
    var local_unregister: (String) -> Void = { uuid in }
    public func register() {
        local_unregister = DataProvider.shared.register(view: self)
    }
    
    public func unregister() {
        local_unregister(id)
    }
    
    public func inflate(data: T) {
        self.loadingView.isHidden = true
        self.onInflate?(data)
    }
    
    public func inflate(datas: [T]) {
        self.loadingView.isHidden = true
        self.onInflateList?(datas)
    }
    
    public func setLoading(view: BaseView) {
        self.loadingView.isHidden = false
        self.loadingView.addSubview(view)
        view.makeEasyConstraintsFull()
    }
    
    var onInflate: ((T) -> Void)?
    public func setOnInflate(callback: @escaping (T) -> Void) {
        self.onInflate = callback
    }
    
    var onInflateList: (([T]) -> Void)?
    public func setOnInflateList(callback: @escaping ([T]) -> Void) {
        self.onInflateList = callback
    }
}
