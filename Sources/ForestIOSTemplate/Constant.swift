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
    public let width: CGFloat
    public let height: CGFloat
    public let image: String
    public let alignV: ViewAlignV
    public let alignH: ViewAlignH
    
    public init(width: CGFloat, height: CGFloat, image: String, alignV: ViewAlignV = .center, alignH: ViewAlignH = .center) {
        self.width = width
        self.height = height
        self.image = image
        self.alignV = alignV
        self.alignH = alignH
    }
    
    func inflateConstraints(_ make: ConstraintMaker, voffset: CGFloat = 0, hoffset: CGFloat = 0) {
        alignV.inflateConstraints(make, voffset: voffset)
        alignH.inflateConstraints(make, hoffset: hoffset)
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
    public let alignV: ViewAlignV
    public let alignH: ViewAlignH
    
    public init(text: String, color: UIColor, font: UIFont, alignV: ViewAlignV = .center, alignH: ViewAlignH = .center) {
        self.text = text
        self.color = color
        self.font = font
        self.alignV = alignV
        self.alignH = alignH
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
    
    func setToTextField(_ textField: UITextField) {
        textField.setText(text, color, font)
    }
    
    func setToTextView(_ textView: UITextView) {
        textView.setText(text, color, font)
    }
    
    func inflateConstraints(_ make: ConstraintMaker, voffset: CGFloat = 0, hoffset: CGFloat = 0) {
        alignV.inflateConstraints(make, voffset: voffset)
        alignH.inflateConstraints(make, hoffset: hoffset)
    }
}

public enum ViewAlignH {
    case left
    case center
    case right
    
    func inflateConstraints(_ make: ConstraintMaker, hoffset: CGFloat = 0) {
        switch self {
        case .left: make.leading.equalToSuperview().offset(hoffset)
        case .center: make.centerX.equalToSuperview().offset(hoffset)
        case .right: make.trailing.equalToSuperview().offset(hoffset)
        }
    }
}

public enum ViewAlignV {
    case top
    case center
    case bottom
    
    func inflateConstraints(_ make: ConstraintMaker, voffset: CGFloat = 0) {
        switch self {
        case .top: make.top.equalToSuperview().offset(voffset)
        case .center: make.centerY.equalToSuperview().offset(voffset)
        case .bottom: make.bottom.equalToSuperview().offset(voffset)
        }
    }
}
