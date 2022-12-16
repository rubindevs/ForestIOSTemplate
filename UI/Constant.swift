//
//  Constant.swift
//  ForestIOSTemplate
//
//  Created by 염태규 on 2022/12/15.
//

import Foundation
import UIKit
import SnapKit

enum ViewHAlign {
    case left
    case center
    case right
    case side
    
    func inflateContraints(_ make: ConstraintMaker) {
        switch self {
        case .left: make.leading.equalToSuperview()
        case .center: make.centerX.equalToSuperview()
        case .right: make.trailing.equalToSuperview()
        case .side: break
        }
    }
    
    func inflateLeftContraints(_ make: ConstraintMaker, _ view: UIView? = nil, _ offset: Int = 0) {
        switch self {
        case .left: make.leading.equalToSuperview()
        case .center: make.centerX.equalToSuperview()
        case .right: make.trailing.equalTo(view!.snp.leading).offset(-offset)
        case .side: make.leading.equalToSuperview()
        }
    }
    
    func inflateRightContraints(_ make: ConstraintMaker, _ view: UIView? = nil, _ offset: Int = 0) {
        switch self {
        case .left: make.leading.equalTo(view!.snp.trailing).offset(offset)
        case .center: make.leading.equalTo(view!.snp.trailing).offset(offset)
        case .right: make.trailing.equalToSuperview()
        case .side: make.trailing.equalToSuperview()
        }
    }
}

enum ViewVAlign {
    case top
    case center
    case bottom
    
    func inflateContraints(_ make: ConstraintMaker) {
        switch self {
        case .top: make.top.equalToSuperview()
        case .center: make.centerY.equalToSuperview()
        case .bottom: make.bottom.equalToSuperview()
        }
    }
}
