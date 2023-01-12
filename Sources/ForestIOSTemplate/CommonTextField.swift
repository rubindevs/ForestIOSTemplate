//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/27.
//

import Foundation
import UIKit
import SnapKit

public class CommonTextField: BaseView, UITextFieldDelegate {
    
    public var label_title = UILabel()
    public var layout_tf = BaseView()
    public var label_placeholder = UILabel()
    public var textField = UITextField()
    public var callback: ((String?) -> Void)? = nil
    
    public override func initViews() {
        addSubview(label_title)
        label_title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.top.equalToSuperview()
        }
        label_title.isHidden = true
        
        addSubview(layout_tf)
        layout_tf.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        layout_tf.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(0)
        }
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        layout_tf.addSubview(label_placeholder)
        label_placeholder.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.centerY.equalTo(textField.snp.centerY)
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        label_placeholder.isHidden = true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if (textField.text?.count ?? 0) == 0 {
            label_placeholder.isHidden = false
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        callback?(textField.text)
    }
    
    public func setTitle(text: ViewText, intervalH: CGFloat, intervalV: CGFloat) {
        label_title.isHidden = false
        label_title.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(intervalH)
        }
        text.setToLabel(label_title)
        
        layout_tf.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(label_title.snp.bottom).offset(intervalV)
            make.bottom.equalToSuperview()
        }
    }
    
    public func set(fieldText: ViewText, placeText: ViewText, intervalH: CGFloat, callback: @escaping (String?) -> Void) {
        self.callback = callback
        textField.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(intervalH)
            make.trailing.equalToSuperview().offset(-intervalH)
        }
        fieldText.setToTextField(textField)
        
        label_placeholder.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(intervalH)
        }
        placeText.setToLabel(label_placeholder)
        label_placeholder.isHidden = !fieldText.text.isEmpty
    }
    
    public func update(intervalH: CGFloat) {
        textField.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(intervalH)
        }
        label_placeholder.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(intervalH)
        }
    }
}
