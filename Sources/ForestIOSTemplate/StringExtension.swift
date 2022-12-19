//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/17.
//

import Foundation
import UIKit

extension String {
    public var url: URL? {
        if let url = URL(string: self) {
            return url
        }
        return nil
    }
}
