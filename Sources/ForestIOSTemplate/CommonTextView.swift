//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/28.
//

import Foundation
import UIKit
import SnapKit

public class CommonTextView: BaseView, UITextViewDelegate {
    
    public var label_title = UILabel()
    public var layout_tf = BaseView()
    public var label_placeholder = UILabel()
    public var textView = UITextView()
    public var callback: ((String?) -> Void)? = nil
    
    public override func initViews(parent: UIViewController?) {
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
        
        layout_tf.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
        }
        textView.delegate = self
        
        layout_tf.addSubview(label_placeholder)
        label_placeholder.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
        }
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        label_placeholder.isHidden = true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text?.count ?? 0) == 0 {
            label_placeholder.isHidden = false
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        callback?(textView.text)
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
    
    public func set(text: ViewText, placeText: ViewText, intervalH: CGFloat, intervalV: CGFloat, callback: @escaping (String?) -> Void) {
        self.callback = callback
        textView.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(intervalH)
            make.trailing.equalToSuperview().offset(-intervalH)
            make.top.equalToSuperview().offset(intervalV)
            make.bottom.equalToSuperview().offset(-intervalV)
        }
        text.setToTextView(textView)
        
        label_placeholder.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(intervalH)
            make.top.equalToSuperview().offset(intervalV + 4)
        }
        placeText.setToLabel(label_placeholder)
    }
}

