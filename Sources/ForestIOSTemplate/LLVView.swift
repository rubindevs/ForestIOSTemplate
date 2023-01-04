//
//  SIDLButton.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//

// Aligns left, center, right
// |Label   |  Label  |   Label|
// |Label   |  Label  |   Label|
import Foundation
import UIKit
import SnapKit

public class LLVView: BaseView {
    
    public var label_top = UILabel()
    public var label_bottom = UILabel()
    
    public override func initViews() {
        addSubview(label_top)
        label_top.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        addSubview(label_bottom)
        label_bottom.snp.makeConstraints { make in
            make.top.equalTo(label_top.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    public func set(label1: ViewText, label2: ViewText, interval: CGFloat) {
        label_top.snp.remakeConstraints { make in
            if label1.alignV == .center && label2.alignV == .center {
                label1.alignV.inflateConstraints(make, voffset: -(label2.getHeight(width: 0) + interval) / 2)
            } else if label1.alignV == .bottom && label2.alignV == .bottom {
                make.bottom.equalTo(label_bottom.snp.top)
            } else {
                label1.alignV.inflateConstraints(make)
            }
            label1.alignH.inflateConstraints(make)
        }
        label1.setToLabel(label_top)
        
        label_bottom.snp.remakeConstraints { make in
            if label1.alignV == .center && label2.alignV == .center {
                label2.alignV.inflateConstraints(make, voffset: (label1.getHeight(width: 0) + interval) / 2)
            } else if label1.alignV == .top && label2.alignV == .top {
                make.top.equalTo(label_top.snp.bottom).offset(interval)
            } else {
                label2.alignV.inflateConstraints(make)
            }
            label2.alignH.inflateConstraints(make)
        }
        label2.setToLabel(label_bottom)
    }
}
