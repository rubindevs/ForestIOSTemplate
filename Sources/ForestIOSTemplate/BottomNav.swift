//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/17.
//

import Foundation
import UIKit
import SnapKit

public class BottomNav: BaseView {
    
    public struct NavItem {
        public let image: ViewImage
        public let title: ViewText
        public let callback: () -> Void
        
        public init(image: ViewImage, title: ViewText, callback: @escaping () -> Void) {
            self.image = image
            self.title = title
            self.callback = callback
        }
    }
    
    public override func initViews(parent: UIViewController?) {
        
    }
    
    public func set(items: [NavItem]) {
        subviews.forEach { $0.removeFromSuperview() }
        var beforeView: UIView? = nil
        for i in 0..<items.count {
            let view = BaseView()
            addSubview(view)
            view.snp.makeConstraints { make in
                if let beforeView = beforeView {
                    make.leading.equalTo(beforeView.snp.trailing)
                } else {
                    make.leading.equalToSuperview()
                }
                make.width.equalToSuperview().multipliedBy(CGFloat(1) / CGFloat(items.count))
                make.top.bottom.equalToSuperview()
            }
            inflateNav(view: view, item: items[i])
            view.setOnClickListener(listener: items[i].callback)
            beforeView = view
        }
    }
    
    func inflateNav(view: UIView, item: NavItem) {
        view.subviews.forEach { $0.removeFromSuperview() }
        if item.title.text.isEmpty {
            let imageView = UIImageView()
            view.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                item.image.inflateConstraints(make)
            }
            item.image.setToImageView(imageView)
        } else {
            let imageView = UIImageView()
            view.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-item.title.getHeight(width: 0) / 2)
                item.image.inflateConstraints(make)
            }
            item.image.setToImageView(imageView)
            
            let label = UILabel()
            view.addSubview(label)
            label.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(imageView.snp.bottom)
            }
            item.title.setToLabel(label)
        }
    }
}
