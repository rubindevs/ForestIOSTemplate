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
    
    var image_left = UIImageView()
    var label_right = UILabel()
    
    public override func initViews() {
        addSubview(image_left)
        image_left.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(label_right)
        label_right.snp.makeConstraints { make in
            make.leading.equalTo(image_left.snp.trailing)
            make.centerY.equalToSuperview()
        }
    }
    
    public func set(alignV: ViewVAlign, alignH: ViewHAlign, interval: Int) {
        image_left.snp.remakeConstraints { make in
            alignV.inflateContraints(make)
            alignH.inflateLeftContraints(make, label_right, interval)
        }
        
        label_right.snp.remakeConstraints { make in
            alignV.inflateContraints(make)
            alignH.inflateRightContraints(make, image_left, interval)
        }
    }
}
