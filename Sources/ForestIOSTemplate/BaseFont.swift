//
//  BaseFont.swift
//  ForestIOSTemplate
//
//  Created by 염태규 on 2022/12/15.
//

import Foundation
import UIKit

public enum FontFamily {
    case Default
    
    func get(_ iphoneSize: CGFloat, _ weight: Int) -> UIFont {
        var size = iphoneSize
        if weight == 400 {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        } else if weight == 500 {
            return UIFont.systemFont(ofSize: size, weight: .medium)
        } else if weight == 600 {
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        } else if weight == 700 {
            return UIFont.systemFont(ofSize: size, weight: .bold)
        } else {
            return  UIFont.systemFont(ofSize: size, weight: .regular)
        }
    }
}

extension UIView {
    public func setText(_ text: String, _ color: UIColor, _ font: UIFont, state: UIControl.State = .normal) {
        if let label = self as? UILabel {
            label.text = text
            label.textColor = color
            label.font = font
        } else if let button = self as? UIButton {
            button.titleLabel?.font = font
            button.setTitle(text, for: state)
            button.setTitleColor(color, for: state)
        } else if let textfield = self as? UITextField {
            textfield.text = text
            textfield.textColor = color
            textfield.font = font
        } else if let textview = self as? UITextView {
            textview.text = text
            textview.textColor = color
            textview.font = font
        }
    }
}

extension UIImageView {
    public func setImage(_ image: String, _ color: UIColor? = nil) {
        if let color = color {
            self.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
            self.tintColor = color
        } else {
            self.image = UIImage(named: image)
        }
    }
}
