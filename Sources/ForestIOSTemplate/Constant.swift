//
//  Constant.swift
//  ForestIOSTemplate
//
//  Created by 염태규 on 2022/12/15.
//

import Foundation
import UIKit
import SnapKit

public struct ViewImage {
    public let width: Int
    public let height: Int
    public let image: String
    
    public init(width: Int, height: Int, image: String) {
        self.width = width
        self.height = height
        self.image = image
    }
    
    func inflateConstraints(_ make: ConstraintMaker) {
        make.width.equalTo(width)
        make.height.equalTo(height)
    }
    
    func setToImageView(_ imageView: UIImageView) {
        imageView.setImage(image)
    }
}

public struct ViewText {
    public let text: String
    public let color: UIColor
    public let font: UIFont
    
    public init(text: String, color: UIColor, font: UIFont) {
        self.text = text
        self.color = color
        self.font = font
    }
    
    func getWidth(height: CGFloat) -> CGFloat {
        var height = height == 0 ? UIScreen.main.bounds.height : height
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func getHeight(width: CGFloat) -> CGFloat {
        var width = width == 0 ? UIScreen.main.bounds.width : width
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }
    
    func setToLabel(_ label: UILabel) {
        label.setText(text, color, font)
    }
}

public enum ViewHAlign {
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

public enum ViewVAlign {
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
