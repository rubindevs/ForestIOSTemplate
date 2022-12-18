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
    
    public func set(label1: ViewText, label2: ViewText, interval: CGFloat) {
        label_left.snp.remakeConstraints { make in
            if label1.alignH == .center && label2.alignH == .center {
                label1.inflateConstraints(make, hoffset: -(label2.getWidth(height: 0) + interval) / 2)
            } else {
                label1.inflateConstraints(make)
            }
        }
        label1.setToLabel(label_left)
        
        label_right.snp.remakeConstraints { make in
            if label1.alignH == .left && label2.alignH == .left {
                make.leading.equalTo(label_left.snp.trailing).offset(interval)
                label2.alignV.inflateConstraints(make)
            } else if label1.alignH == .right && label2.alignH == .right {
                make.trailing.equalTo(label_left.snp.leading).offset(-interval)
                label2.alignV.inflateConstraints(make)
            } else if label1.alignH == .center && label2.alignH == .center {
                label2.inflateConstraints(make, hoffset: (label1.getWidth(height: 0) + interval) / 2)
            } else {
                label2.inflateConstraints(make)
            }
        }
        label2.setToLabel(label_right)
    }
}
