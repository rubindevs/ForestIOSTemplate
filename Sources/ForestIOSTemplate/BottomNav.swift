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
        public let image_on: ViewImage
        public let image_off: ViewImage
        public let title: ViewText
        public let callback: () -> Void
        
        public init(image_on: ViewImage, image_off: ViewImage, title: ViewText, callback: @escaping () -> Void) {
            self.image_on = image_on
            self.image_off = image_off
            self.title = title
            self.callback = callback
        }
    }
    
    public override func initViews() {
        
    }
    
    var items: [NavItem] = []
    public func set(items: [NavItem]) {
        self.items = items
        subviews.forEach { $0.removeFromSuperview() }
        var beforeView: UIView? = nil
        for i in 0..<items.count {
            let view = BaseView()
            view.tag = i
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
            view.setOnClickListener {
                self.activateItem(item: items[i], tag: i)
                items[i].callback()
            }
            beforeView = view
        }
        if items.count > 0 {
            self.activateItem(item: items[0], tag: 0)
        }
    }
    
    func activateItem(item: NavItem, tag: Int) {
        for i in 0..<self.subviews.count {
            subviews[i].subviews.filter { $0 is UIImageView }.map { $0 as! UIImageView }.forEach {
                if subviews[i].tag == tag {
                    items[i].image_on.setToImageView($0)
                } else {
                    items[i].image_off.setToImageView($0)
                }
            }
        }
    }
    
    func inflateNav(view: UIView, item: NavItem) {
        view.subviews.forEach { $0.removeFromSuperview() }
        if item.title.text.isEmpty {
            let imageView = UIImageView()
            view.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                item.image_off.inflateConstraints(make)
            }
            item.image_off.setToImageView(imageView)
        } else {
            let imageView = UIImageView()
            view.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-item.title.getHeight(width: 0) / 2)
                item.image_off.inflateConstraints(make)
            }
            item.image_off.setToImageView(imageView)
            
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
