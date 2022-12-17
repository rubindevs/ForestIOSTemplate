//
//  SIDLButton.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//


// i + dlv
import Foundation
import UIKit
import SnapKit

public class SILLView: BaseView {
    
    public var image_left = UIImageView()
    public var view_right = LLVView()
    
    public override func initViews(parent: UIViewController?) {
        addSubview(image_left)
        image_left.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(view_right)
        view_right.snp.makeConstraints { make in
            make.leading.equalTo(image_left.snp.trailing)
            make.centerY.equalToSuperview()
        }
    }
    
    public func set(alignV: ViewVAlign, alignH: ViewHAlign, interval: Int) {
        image_left.snp.remakeConstraints { make in
            alignV.inflateContraints(make)
            alignH.inflateLeftContraints(make, view_right, interval)
        }
        
        view_right.snp.remakeConstraints { make in
            alignV.inflateContraints(make)
            alignH.inflateRightContraints(make, image_left, interval)
        }
    }
}
