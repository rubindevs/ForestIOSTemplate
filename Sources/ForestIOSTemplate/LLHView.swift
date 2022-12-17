//
//  SIDLButton.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//

// aligns
// Label                Label
//         Label Label
// Label Label
//                Label Label
import Foundation
import UIKit
import SnapKit

public class LLHView: BaseView {
    
    public var label_left = UILabel()
    public var label_right = UILabel()
    
    public override func initViews(parent: UIViewController?) {
        addSubview(label_left)
        label_left.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(label_right)
        label_right.snp.makeConstraints { make in
            make.leading.equalTo(label_left.snp.trailing)
            make.centerY.equalToSuperview()
        }
    }
    
    public func set(alignV: ViewVAlign, alignH: ViewHAlign, interval: Int) {
        label_left.snp.remakeConstraints { make in
            alignV.inflateContraints(make)
            alignH.inflateLeftContraints(make, label_right, interval)
        }
        
        label_right.snp.remakeConstraints { make in
            alignV.inflateContraints(make)
            alignH.inflateRightContraints(make, label_left, interval)
        }
    }
}
