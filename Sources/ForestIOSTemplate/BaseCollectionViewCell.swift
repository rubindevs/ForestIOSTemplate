//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/23.
//

import Foundation
import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func initViews() {
    }
}
