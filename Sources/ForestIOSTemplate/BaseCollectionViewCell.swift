//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/23.
//

import Foundation
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func initViews() {
    }
}
