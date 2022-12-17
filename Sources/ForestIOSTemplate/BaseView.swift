//
//  BaseView.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//

// radius
// circle half
import Foundation
import UIKit
import SnapKit

public class BaseView: UIView {
    
    struct Corner {
        let radius: CGFloat
        let type: Types
        enum Types {
            case radius
            case halfcircle
        }
    }
    var corner = Corner(radius: 0, type: .radius)
    var fixedWidth: CGFloat = 0
    var fixedHeight: CGFloat = 0
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func layoutSubviews() {
        switch corner.type {
        case .radius:
            self.layer.cornerRadius = corner.radius
        case .halfcircle:
            self.layer.cornerRadius = self.frame.height / 2
        }
        fixedWidth = self.frame.width
        fixedHeight = self.frame.height
    }
    
    init() {
        super.init(frame: CGRect.zero)
        initViews()
    }
    
    open func initViews(parent: UIViewController? = nil) {
        
    }
    
    var clickListener: (() -> Void)?
    var button: UIButton?
    func setOnClickListener(listener: @escaping () -> Void) {
        self.clickListener = listener
        button?.removeFromSuperview()
        button = UIButton()
        if let button = button {
            addSubview(button)
            button.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        }
    }
    
    @objc func onClick(_ sender: UIButton) {
        self.clickListener?()
    }
    
    func set(corner: Corner) {
        self.corner = corner
    }
    
    
    func makeEasyConstraints(rootView: UIView, topView: UIView? = nil, bottomView: UIView? = nil, leadingView: UIView? = nil, trailingView: UIView? = nil, isSafe: Bool = false, _ formats: String...) {
        rootView.addSubview(self)
        self.snp.makeEasyConstraints(topView: topView, bottomView: bottomView, leadingView: leadingView, trailingView: trailingView, completion: { width, height in
            self.fixedWidth = CGFloat(width)
            self.fixedHeight = CGFloat(height)
        }, formats)
    }
    
    func makeEasyConstraints(topView: UIView? = nil, bottomView: UIView? = nil, leadingView: UIView? = nil, trailingView: UIView? = nil, _ formats: String...) {
        self.snp.makeEasyConstraints(topView: topView, bottomView: bottomView, leadingView: leadingView, trailingView: trailingView, completion: { width, height in
            self.fixedWidth = CGFloat(width)
            self.fixedHeight = CGFloat(height)
        }, formats)
    }
    
    public func makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.snp.makeConstraints(closure)
    }
    
    var width: CGFloat {
        return fixedWidth
    }
    
    var height: CGFloat {
        return fixedHeight
    }
}
