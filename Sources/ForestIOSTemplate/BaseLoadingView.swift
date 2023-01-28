//
//  File.swift
//  
//
//  Created by 염태규 on 2023/01/28.
//

import Foundation
import UIKit

open class BaseLoadingView: BaseView {
    
    public var loadingView: BaseView?
    
    open func onShowLoading() {
    }
    
    open func onStopLoading() {
    }
    
    open func setLoading(view: BaseView) {
        self.loadingView?.removeFromSuperview()
        self.loadingView = BaseView()
        if let loadingView = loadingView {
            self.addSubview(loadingView)
            loadingView.makeEasyConstraintsFull()
            loadingView.addSubview(view)
            view.makeEasyConstraintsFull()
        }
    }
}
