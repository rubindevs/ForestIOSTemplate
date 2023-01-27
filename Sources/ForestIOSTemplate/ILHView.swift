//
//  ILHButton.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//

// Image Label Horozontal
import Foundation
import UIKit
import SnapKit

public class ILHView: BaseView {
    
    public var image_left = IView()
    public var label_right = UILabel()
    
    public override func initViews(rootView: BaseView) {
        mainView.addSubview(image_left)
        image_left.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        mainView.addSubview(label_right)
        label_right.snp.makeConstraints { make in
            make.leading.equalTo(image_left.snp.trailing)
            make.centerY.equalToSuperview()
        }
    }
    
    public func set(image: ViewImage, label: ViewText, interval: CGFloat, intervalH: CGFloat = 0, intervalV: CGFloat = 0) {
        image_left.snp.remakeConstraints { make in
            if image.alignH == .center && label.alignH == .center {
                image.inflateConstraints(make, hoffset: -(label.getWidth(height: 0) + interval) / 2)
            } else {
                image.inflateConstraints(make, voffset: intervalV, hoffset: intervalH)
            }
        }
        image_left.set(image: image)
        
        label_right.snp.remakeConstraints { make in
            if image.alignH == .left && label.alignH == .left {
                make.leading.equalTo(image_left.snp.trailing).offset(interval)
                label.alignV.inflateConstraints(make, voffset: intervalV)
            } else if image.alignH == .right && label.alignH == .right {
                make.trailing.equalTo(image_left.snp.leading).offset(-interval)
                label.alignV.inflateConstraints(make, voffset: intervalV)
            } else if image.alignH == .center && label.alignH == .center {
                label.inflateConstraints(make, hoffset: (image.width + interval) / 2)
            } else {
                label.inflateConstraints(make, voffset: intervalV, hoffset: intervalH)
            }
        }
        label.setToLabel(label_right)
    }
}
