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

open class BaseView: UIView {
    
    public struct Corner {
        public let radius: CGFloat
        public let type: Types
        public enum Types {
            case radius
            case halfcircle
        }
        public init(radius: CGFloat, type: Types) {
            self.radius = radius
            self.type = type
        }
    }
    
    public struct Gradient {
        public let colors: [UIColor]
        public let locations: [NSNumber]
        public let startPoint: CGPoint?
        public let endPoint: CGPoint?
        public var isDraw: Bool
    }
    
    var corner = Corner(radius: 0, type: .radius)
    var fixedWidth: CGFloat = 0
    var fixedHeight: CGFloat = 0
    public var mainView = UIView()
    public var gradient: Gradient? = nil
    
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
        if let gradient = gradient, !gradient.isDraw {
            setGradientBackground(colors: gradient.colors, locations: gradient.locations, frame: self.frame, startPoint: gradient.startPoint, endPoint: gradient.endPoint)
            self.gradient?.isDraw = true
        }
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        addSubview(mainView)
        mainView.snp.makeEasyConstraints("ls0", "rs0", "ts0", "bs0")
        initViews(rootView: mainView)
    }
    
    public var parent: UIViewController?
    public convenience init(parent: UIViewController?) {
        self.init()
        self.parent = parent
    }
    
    open func initViews(rootView: UIView) {
        
    }
    
    var clickListener: (() -> Void)?
    var button: UIButton?
    public func setOnClickListener(listener: @escaping () -> Void) {
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
    
    public func setDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }
    
    public func set(corner: Corner) {
        self.corner = corner
    }
    
    public func makeEasyConstraintsFull() {
        self.snp.makeEasyConstraints(completion: { width, height in
            self.fixedWidth = CGFloat(width)
            self.fixedHeight = CGFloat(height)
        }, "ls0", "rs0", "ts0", "bs0")
    }
    
    public func makeEasyConstraints(rootView: UIView? = nil, topView: UIView? = nil, bottomView: UIView? = nil, leadingView: UIView? = nil, trailingView: UIView? = nil, _ formats: String...) {
        rootView?.addSubview(self)
        self.snp.makeEasyConstraints(topView: topView, bottomView: bottomView, leadingView: leadingView, trailingView: trailingView, completion: { width, height in
            self.fixedWidth = CGFloat(width)
            self.fixedHeight = CGFloat(height)
        }, formats)
    }
    
    public func makeEasyConstraintItems(top: ConstraintItem? = nil, bottom: ConstraintItem? = nil, leading: ConstraintItem? = nil, trailing: ConstraintItem? = nil, _ formats: String...) {
        self.snp.makeEasyConstraintItems(top: top, bottom: bottom, leading: leading, trailing: trailing, completion: { width, height in
            self.fixedWidth = CGFloat(width)
            self.fixedHeight = CGFloat(height)
        }, formats)
    }
    
    public func makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.snp.makeConstraints(closure)
    }
    
    public var width: CGFloat {
        return fixedWidth
    }
    
    public var height: CGFloat {
        return fixedHeight
    }
    
    public func setGradient(colors: [UIColor], locations: [NSNumber], startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) {
        self.gradient = Gradient(colors: colors, locations: locations, startPoint: startPoint, endPoint: endPoint, isDraw: false)
    }
}
