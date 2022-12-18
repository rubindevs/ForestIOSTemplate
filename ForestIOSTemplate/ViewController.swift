//
//  ViewController.swift
//  ForestIOSTemplate
//
//  Created by 염태규 on 2022/12/15.
//

import UIKit

class ViewController: UIViewController {
    let layout = layout_view()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layout.initViews(view)
    }

}

class layout_view: BaseLayout {
    
    override func initViews(_ rootView: UIView) {
//        let view = LLHView()
//        view.makeEasyConstraints(rootView: rootView, "ls20", "ts100", "w200", "h200")
//        view.backgroundColor = .red
//        view.set(alignV: .center, alignH: .right, interval: 5)
//        view.label_left.setText("Test", .white, FontFamily.Default.get(14, 400))
//        view.label_right.setText("Test2", .white, FontFamily.Default.get(14, 400))
        
        let view = BottomNav()
        view.makeEasyConstraints(rootView: rootView, "ls0", "bs0", "rs0", "h200")
        let item = BottomNav.NavItem(
            image: ViewImage(width: 61, height: 61, image: "icon_user_empty", alignV: .center, alignH: .center),
            title: ViewText(text: "Hi", color: .white, font: FontFamily.Default.get(14, 400), alignV: .center, alignH: .center)) {
                print("hello")
            }
        view.set(items: [item, item, item, item])
    }
}

