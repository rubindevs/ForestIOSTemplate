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
        self.onInflate?(data)
    }
    
    open func inflate(datas: [T]) {
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
    
    open func onShowLoading() {
        Task {
            let _ = await loadingView?.animateAlpha(show: true)
            await loadingView?.onShowLoading()
        }
    }
    
    open func onStopLoading() {
        Task {
            await loadingView?.onStopLoading()
            let _ = await loadingView?.animateAlpha(show: false)
        }
    }
    
    public var loadingView: BaseLoadingView?
    open func setLoading(view: BaseLoadingView) {
        self.loadingView?.removeFromSuperview()
        self.loadingView = view
        self.addSubview(view)
        view.makeEasyConstraintsFull()
        view.alpha = 1
        view.isHidden = false
    }
}
