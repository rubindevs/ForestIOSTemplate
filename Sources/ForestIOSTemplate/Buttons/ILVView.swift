//
//  ILHButton.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//

import Foundation
import UIKit
import SnapKit

class ILVView: BaseView {
    
    var image_top = UIImageView()
    var label_bottom = UILabel()
    
    override func initViews(parent: UIViewController?) {
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
    
    func set(align: ViewVAlign, interval: Int) {
        image_top.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            align.inflateContraints(make)
        }
        
        label_bottom.snp.remakeConstraints { make in
            make.top.equalTo(image_top.snp.bottom).offset(interval)
            align.inflateContraints(make)
        }
    }
}
