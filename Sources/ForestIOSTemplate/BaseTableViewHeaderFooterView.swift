//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/27.
//

import Foundation
import UIKit

open class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initViews()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func initViews() {
    }
}
