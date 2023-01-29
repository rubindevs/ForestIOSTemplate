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
    
    func animateAlpha(show: Bool, duration: CGFloat = 0.3) async -> Bool {
        let start = show ? 0 : 1.0
        let end = show ? 1.0 : 0
        self.alpha = start
        self.isHidden = false
        return await withCheckedContinuation { continuation in
            UIView.animate(withDuration: duration, animations: {
                self.alpha = end
            }, completion: { finished in
                self.isHidden = show ? false : true
                continuation.resume(returning: true)
            })
        }
    }
    
    func animateTransition(start: CGPoint, end: CGPoint, duration: CGFloat = 0.3) async -> Bool {
        self.transform = CGAffineTransform(translationX: start.x, y: start.y)
        return await withCheckedContinuation { continuation in
            UIView.animate(withDuration: duration, animations: {
                self.transform = CGAffineTransform(translationX: end.x, y: end.y)
            }, completion: { finished in
                continuation.resume(returning: true)
            })
        }
    }
}
