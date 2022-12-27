//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/27.
//

import Foundation
import SnapKit
import UIKit

public class LView: BaseView {
    
    public var label = UILabel()
    
    public override func initViews(parent: UIViewController?) {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    public func set(text: ViewText, intervalH: CGFloat = 0, intervalV: CGFloat = 0) {
        label.snp.remakeConstraints { make in
            text.alignV.inflateConstraints(make, voffset: intervalV)
            text.alignH.inflateConstraints(make, hoffset: intervalH)
        }
        text.setToLabel(label)
    }
}
