//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/18.
//

import Foundation
import UIKit
import SnapKit

public class SearchTextField: BaseView, UITextFieldDelegate {
    
    public var view_image = UIImageView()
    public var textField = UITextField()
    public var callback: ((String?) -> Void)? = nil
    
    public override func initViews(parent: UIViewController?) {
        addSubview(view_image)
        view_image.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalTo(view_image.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        callback?(textField.text)
    }
    
    public func set(image: ViewImage?, interval: CGFloat, callback: @escaping (String?) -> Void) {
        self.view_image.isHidden = image == nil
        self.callback = callback
        self.view_image.snp.remakeConstraints { make in
            image?.inflateConstraints(make, hoffset: interval)
        }
        image?.setToImageView(view_image)
        
        self.textField.snp.remakeConstraints { make in
            if image != nil {
                make.leading.equalTo(view_image.snp.trailing)
            } else {
                make.leading.equalToSuperview()
            }
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

