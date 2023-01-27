//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/27.
//

import Foundation
import SnapKit
import UIKit

public class IView: BaseView {
    
    public var view_image = UIImageView()
    
    public override func initViews(rootView: BaseView) {
        mainView.addSubview(view_image)
        view_image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func set(image: ViewImage, intervalH: CGFloat = 0, intervalV: CGFloat = 0) {
        view_image.snp.remakeConstraints { make in
            image.inflateConstraints(make)
        }
        image.setToImageView(view_image)
    }
}

