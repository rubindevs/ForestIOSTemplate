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
    
    public override func initViews(parent: UIViewController?) {
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
    
    public func set(align: ViewHAlign, interval: Int) {
        label_top.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            align.inflateContraints(make)
        }
        
        label_bottom.snp.remakeConstraints { make in
            make.top.equalTo(label_top.snp.bottom).offset(interval)
            align.inflateContraints(make)
        }
    }
}
