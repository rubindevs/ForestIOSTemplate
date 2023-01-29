//
//  File.swift
//  
//
//  Created by 염태규 on 2023/01/29.
//

import Foundation
import UIKit

public extension UIView {
    
    func setGradientBackground(colors: [UIColor]?, locations: [NSNumber]?, frame: CGRect?, startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors?.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.frame = frame ?? self.bounds
        if let startPoint = startPoint {
            gradientLayer.startPoint = startPoint
        }
        if let endPoint = endPoint {
            gradientLayer.endPoint = endPoint
        }
                
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}
