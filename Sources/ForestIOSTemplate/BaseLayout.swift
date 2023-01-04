//
//  BaseLayout.swift
//  ForestIOSTemplate
//
//  Created by 염태규 on 2022/12/15.
//

import Foundation
import UIKit

open class BaseLayout {
    
    required public init() {
    }
    
    var parent: UIViewController?
    convenience init(parent: UIViewController) {
        self.init()
        self.parent = parent
    }
    
    open func initViews(_ rootView: UIView) {
        
    }
}
