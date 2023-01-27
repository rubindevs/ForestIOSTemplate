//
//  SIDLButton.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//


// i + dlv
import Foundation
import UIKit
import SnapKit

public class ILLVLeftView: BaseView {
    
    public var image_left = UIImageView()
    public var view_right = LLVView()
    
    public override func initViews(rootView: BaseView) {
        rootView.addSubview(image_left)
        image_left.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        rootView.addSubview(view_right)
        view_right.snp.makeConstraints { make in
            make.leading.equalTo(image_left.snp.trailing)
            make.centerY.equalToSuperview()
        }
    }
    
    public func set(image: ViewImage, llv: LLVView, interval: Int) {
        if image.alignH != .left {
            return
        }
        subviews.filter { $0 is LLVView }.forEach { $0.removeFromSuperview() }
        image_left.snp.remakeConstraints { make in
            image.inflateConstraints(make)
        }
        image.setToImageView(image_left)
        
        addSubview(llv)
        llv.snp.makeConstraints { make in
            make.leading.equalTo(image_left.snp.trailing).offset(interval)
            make.top.bottom.trailing.equalToSuperview()
        }
    }
}
