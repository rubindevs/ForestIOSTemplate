//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/27.
//

import Foundation
import UIKit

open class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView {
    public var loadingView = BaseView()
    public var mainView = BaseView()
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(mainView)
        mainView.makeEasyConstraintsFull()
        addSubview(loadingView)
        loadingView.makeEasyConstraintsFull()
        loadingView.isHidden = true
        initViews(rootView: mainView)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func initViews(rootView: BaseView) {
    }
}
