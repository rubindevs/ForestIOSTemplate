//
//  File.swift
//  
//
//  Created by 염태규 on 2023/01/28.
//

import Foundation
import UIKit
import SnapKit

open class SimpleLoadingView: BaseLoadingView {
    
    let view_loading = UIActivityIndicatorView()
    
    open override func initViews(rootView: UIView) {
        rootView.addSubview(view_loading)
        view_loading.snp.makeEasyConstraints("xs0", "ys0")
        if #available(iOS 13.0, *) {
            view_loading.style = UIActivityIndicatorView.Style.medium
        } else {
            view_loading.style = .white
        }
    }
    
    open override func onShowLoading() {
        view_loading.startAnimating()
    }
    
    open override func onStopLoading() {
        view_loading.stopAnimating()
    }
}
