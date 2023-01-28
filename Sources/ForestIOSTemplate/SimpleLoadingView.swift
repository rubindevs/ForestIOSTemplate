//
//  File.swift
//  
//
//  Created by 염태규 on 2023/01/28.
//

import Foundation
import UIKit
import SnapKit

class SimpleLoadingView: BaseLoadingView {
    
    let view_loading = UIActivityIndicatorView()
    
    override func initViews(rootView: UIView) {
        rootView.addSubview(view_loading)
        view_loading.snp.makeEasyConstraints("xs0", "ys0")
        if #available(iOS 13.0, *) {
            view_loading.style = UIActivityIndicatorView.Style.medium
        } else {
            view_loading.style = .white
        }
    }
    
    override func onShowLoading() {
        view_loading.startAnimating()
    }
    
    override func onStopLoading() {
        view_loading.stopAnimating()
    }
}
