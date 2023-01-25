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
    
    public var label_length = UILabel()
    public var format_length: String?
    public var max_length: Int?
    
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
        
        addSubview(label_length)
        label_length.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(layout_tf.snp.bottom).offset(6)
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
        if let format_length = format_length {
            label_length.text = String(format: format_length, textView.text.count)
        }
        callback?(textView.text)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let max_length = max_length {
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            let numberOfChars = newText.count
            return numberOfChars <= max_length
        }
        return true
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
        textView.textContainer.lineFragmentPadding = .zero
        
        label_placeholder.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(intervalH)
            make.top.equalToSuperview().offset(intervalV + 4)
        }
        placeText.setToLabel(label_placeholder)
        label_placeholder.isHidden = !text.text.isEmpty
    }
    
    public func setLength(text: ViewText, max: Int) {
        if text.text.contains("%d") {
            max_length = max
            format_length = text.text
            label_length.setText(String(format: text.text, textView.text.count), text.color, text.font)
        } else {
            print("error")
        }
    }
}

