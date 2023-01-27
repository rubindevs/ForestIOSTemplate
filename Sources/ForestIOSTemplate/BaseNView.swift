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
    open func register() {
        local_unregister = DataProvider.shared.register(view: self)
    }
    
    open func unregister() {
        local_unregister(id)
    }
    
    open func inflate(data: T) {
        self.loadingView.isHidden = true
        self.onInflate?(data)
    }
    
    open func inflate(datas: [T]) {
        self.loadingView.isHidden = true
        self.onInflateList?(datas)
    }
    
    open func setLoading(view: BaseView) {
        self.loadingView.isHidden = false
        self.loadingView.addSubview(view)
        view.makeEasyConstraintsFull()
    }
    
    var onInflate: ((T) -> Void)?
    open func setOnInflate(callback: @escaping (T) -> Void) {
        self.onInflate = callback
    }
    
    var onInflateList: (([T]) -> Void)?
    open func setOnInflateList(callback: @escaping ([T]) -> Void) {
        self.onInflateList = callback
    }
}
