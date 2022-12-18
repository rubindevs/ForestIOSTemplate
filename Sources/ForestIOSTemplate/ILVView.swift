//
//  ILHButton.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//

import Foundation
import UIKit
import SnapKit

public class ILVView: BaseView {
    
    public var image_top = UIImageView()
    public var label_bottom = UILabel()
    
    public override func initViews(parent: UIViewController?) {
        addSubview(image_top)
        image_top.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        addSubview(label_bottom)
        label_bottom.snp.makeConstraints { make in
            make.top.equalTo(image_top.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    public func set(image: ViewImage, label: ViewText, interval: CGFloat) {
        image_top.snp.remakeConstraints { make in
            if image.alignV == .center && label.alignV == .center {
                image.alignV.inflateConstraints(make, voffset: -(label.getHeight(width: 0) + interval) / 2)
            } else if image.alignV == .bottom && label.alignV == .bottom {
                make.bottom.equalTo(label_bottom.snp.top)
            } else {
                image.alignV.inflateConstraints(make)
            }
            image.alignH.inflateConstraints(make)
        }
        
        label_bottom.snp.remakeConstraints { make in
            if image.alignV == .center && label.alignV == .center {
                label.alignV.inflateConstraints(make, voffset: (image.height + interval) / 2)
            } else if image.alignV == .top && label.alignV == .top {
                make.top.equalTo(image_top.snp.bottom).offset(interval)
            } else {
                label.alignV.inflateConstraints(make)
            }
            label.alignH.inflateConstraints(make)
        }
    }
}
