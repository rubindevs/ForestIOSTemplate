//
//  SnapkitExtension.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//
import UIKit
import SnapKit

public extension ConstraintViewDSL {
    
    func makeEasyConstraints(topView: UIView? = nil, bottomView: UIView? = nil, leadingView: UIView? = nil, trailingView: UIView? = nil, completion: (_ width: Int, _ height: Int) -> Void, _ formats: [String]) {
        self.makeEasyConstraintItems(top: topView?.snp.bottom, bottom: bottomView?.snp.top, leading: leadingView?.snp.trailing, trailing: trailingView?.snp.leading, completion: completion, formats)
    }
    
    func makeEasyConstraintItems(top: ConstraintItem? = nil, bottom: ConstraintItem? = nil, leading: ConstraintItem? = nil, trailing: ConstraintItem? = nil, completion: (_ width: Int, _ height: Int) -> Void, _ formats: [String]) {
        self.makeConstraints { make in
            var fixedWidth = 0
            var fixedHeight = 0
            for format in formats {
                let operation = format[format.startIndex]
                let inherition = format[format.index(after: format.startIndex)] == "s" // s : inherit
                let offset = Int(format[format.index(format.startIndex, offsetBy: inherition ? 2 : 1)...]) ?? 0
                switch operation {
                case "l":
                    if leading != nil {
                        make.leading.equalTo(leading!).offset(offset)
                    } else {
                        make.leading.equalBy(inherition, offset)
                    }
                case "r":
                    if trailing != nil {
                        make.trailing.equalTo(trailing!).offset(offset)
                    } else {
                        make.trailing.equalBy(inherition, offset)
                    }
                case "t":
                    if top != nil {
                        make.top.equalTo(top!).offset(offset)
                    } else {
                        make.top.equalBy(inherition, offset)
                    }
                case "b":
                    if bottom != nil {
                        make.bottom.equalTo(bottom!).offset(offset)
                    } else {
                        make.bottom.equalBy(inherition, offset)
                    }
                case "w":
                    fixedWidth = offset
                    make.width.equalBy(inherition, offset)
                case "h":
                    fixedHeight = offset
                    make.height.equalBy(inherition, offset)
                case "x":
                    make.centerX.equalBy(inherition, offset)
                case "y":
                    make.centerY.equalBy(inherition, offset)
                default:
                    break
                }
            }
            completion(fixedWidth, fixedHeight)
        }
    }
    
    func makeEasyConstraintItems(top: ConstraintItem? = nil, bottom: ConstraintItem? = nil, leading: ConstraintItem? = nil, trailing: ConstraintItem? = nil, completion: (_ width: Int, _ height: Int) -> Void, _ formats: String...) {
        self.makeEasyConstraintItems(top: top, bottom: bottom, leading: leading, trailing: trailing, completion: completion, formats)
    }
    
    func makeEasyConstraints(topView: UIView? = nil, bottomView: UIView? = nil, leadingView: UIView? = nil, trailingView: UIView? = nil, completion: (_ width: Int, _ height: Int) -> Void, _ formats: String...) {
        makeEasyConstraints(topView: topView, bottomView: bottomView, leadingView: leadingView, trailingView: trailingView, completion: completion, formats)
    }
}

extension ConstraintMakerExtendable {
    
    func equalBy(_ inherition: Bool, _ offset: Int) {
        if inherition {
            equalToSuperview().offset(offset)
        } else {
            if offset != 0 {
                equalTo(offset)
            }
        }
    }
}
