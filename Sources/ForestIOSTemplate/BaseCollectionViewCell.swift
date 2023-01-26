//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/23.
//

import Foundation
import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    public var loadingView = BaseView()
    public var mainView = BaseView()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainView)
        mainView.makeEasyConstraintsFull()
        addSubview(loadingView)
        loadingView.makeEasyConstraintsFull()
        loadingView.isHidden = true
        initViews(rootView: mainView)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func initViews(rootView: BaseView) {
    }
}
