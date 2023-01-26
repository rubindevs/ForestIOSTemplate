//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/19.
//

import Foundation
import UIKit

open class BaseTableViewCell: UITableViewCell {
    public var loadingView = BaseView()
    public var mainView = BaseView()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(mainView)
        mainView.makeEasyConstraintsFull()
        addSubview(loadingView)
        loadingView.makeEasyConstraintsFull()
        loadingView.isHidden = true
        initViews(rootView: mainView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func initViews(rootView: BaseView) {
    }
}
