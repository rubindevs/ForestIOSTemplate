//
//  File.swift
//  
//
//  Created by 염태규 on 2023/01/09.
//

import Foundation
import UIKit
import SnapKit

open class SimpleTitleSectionView: BaseTableViewHeaderFooterView {
    
    public var label_title = UILabel()
    
    public override func initViews(rootView: BaseView) {
        rootView.addSubview(label_title)
        label_title.snp.makeEasyConstraints("ls0", "bs0")
    }
    
    open func set(title: ViewText, intervalH: CGFloat, intervalV: CGFloat) {
        label_title.snp.remakeConstraints { make in
            title.alignH.inflateConstraints(make, hoffset: intervalH)
            title.alignV.inflateConstraints(make, voffset: intervalV)
        }
        title.setToLabel(label_title)
    }
}
