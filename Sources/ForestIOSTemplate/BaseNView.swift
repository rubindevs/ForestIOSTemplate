//
//  File.swift
//  
//
//  Created by 염태규 on 2023/01/27.
//

import Foundation
import UIKit

open class BaseNView<T: NCodable>: BaseLoadingView {
    
    let id = UUID().uuidString
    
    var local_unregister: (String) -> Void = { uuid in }
    open func register() {
        local_unregister = DataProvider.shared.register(view: self)
        self.onShowLoading()
    }
    
    open func unregister() {
        local_unregister(id)
    }
    
    open func inflate(data: T) {
        self.onStopLoading()
        self.onInflate?(data)
    }
    
    open func inflate(datas: [T]) {
        self.onStopLoading()
        self.onInflateList?(datas)
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
