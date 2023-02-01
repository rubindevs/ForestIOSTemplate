//
//  File.swift
//  
//
//  Created by 염태규 on 2023/01/27.
//

import Foundation
import UIKit

open class BaseNView<T: NCodable>: BaseView {
    
    public let id = UUID().uuidString
    
    var local_unregister: (String) -> Void = { uuid in }
    open func register() { // TODO: async
        Task {
            local_unregister = await DataProvider.shared.register(view: self)
        }
    }
    
    open func unregister() {
        local_unregister(id)
    }
    
    open func inflate(data: T) {
        // override function : no code
    }
    
    open func inflate(datas: [T]) {
        // override function : no code
    }
    
    open func onShowLoading() async {
        let _ = await loadingView?.animateAlpha(show: true)
        await loadingView?.onShowLoading()
    }
    
    open func onStopLoading() async {
        await loadingView?.onStopLoading()
        let _ = await loadingView?.animateAlpha(show: false)
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
