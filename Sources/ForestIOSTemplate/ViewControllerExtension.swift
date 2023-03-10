//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/18.
//

import Foundation
import UIKit

public extension UIViewController {
    
    func has(_ viewController: UIViewController) -> Bool {
        return children.contains(viewController)
    }
    
    func add(_ viewController: UIViewController, view: UIView? = nil, topView: UIView? = nil) {
        addChild(viewController)
        (view ?? self.view).addSubview(viewController.view)
        viewController.view.snp.makeConstraints { make in
            if let topView = topView {
                make.top.equalTo(topView.snp.bottom)
            } else {
                make.top.equalToSuperview()
            }
            make.leading.trailing.bottom.equalToSuperview()
        }
        viewController.didMove(toParent: self)
    }
    
    func replace(_ from: UIViewController, _ to: UIViewController, _ view: UIView) {
        remove(from)
        add(to, view: view)
    }
    
    func remove(_ viewController: UIViewController) {
        guard children.contains(viewController) else { return }
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

    func presentFull(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        self.present(viewControllerToPresent, animated: animated, completion: completion)
    }
    
    @available(iOS 15.0, *)
    func presentNav(_ viewControllerToPresent: UIViewController, detents: [UISheetPresentationController.Detent] = [.large()], animated: Bool, completion: (() -> Void)? = nil) {
        let nav = UINavigationController(rootViewController: viewControllerToPresent)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = detents
        }
        self.present(nav, animated: animated, completion: completion)
    }
}
