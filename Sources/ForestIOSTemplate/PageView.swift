//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/24.
//

import Foundation
import UIKit
import SnapKit

open class PageView<T, U: BaseLayout>: BaseView {
    
    let controller_page = PagingViewController<T, U>()
    let layout_page = UIView()
    var parent: UIViewController?
    
    open override func initViews() {
        self.parent = parent
        addSubview(layout_page)
        layout_page.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func set(parent: UIViewController, items: [T], inflate: @escaping (Int, T, U) -> Void, current: @escaping (Int) -> Void) {
        if !parent.has(controller_page) {
            parent.add(controller_page, view: layout_page, topView: nil)
        }
        controller_page.set(items: items, inflate: inflate, current: current)
    }
    
    
    class PagingViewController<T, U: BaseLayout>: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

        var pages: [UIViewController] = []
        var items: [T] = []
        var current: ((Int) -> Void)? = nil

        override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
            super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            
            dataSource = self
            delegate = self
        }
        
        func set(items: [T], inflate: @escaping (Int, T, U) -> Void, current: @escaping (Int) -> Void) {
            self.current = current
            if !items.isEmpty {
                pages = (0..<items.count).map { PageViewController(index: $0, item: items[$0], inflate: inflate) }
                setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
            }
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
            let previousIndex = viewControllerIndex - 1
            guard previousIndex >= 0 else { return pages.last }
            guard pages.count > previousIndex else { return nil }
            return pages[previousIndex]
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
            let nextIndex = viewControllerIndex + 1
            guard nextIndex < pages.count else { return pages.first }
            guard pages.count > nextIndex else { return nil }
            return pages[nextIndex]
        }
        
        func presentationCount(for pageViewController: UIPageViewController) -> Int {
            return pages.count
        }
        
        func next() {
            guard let currentViewController = self.viewControllers?.first else { return }
            guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }

            setViewControllers([nextViewController], direction: .forward, animated: true, completion: { completed in self.delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [], transitionCompleted: completed) })
        }
        
        func prev() {
            guard let currentViewController = self.viewControllers?.first else { return }
            guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return }

            setViewControllers([previousViewController], direction: .reverse, animated: true, completion:{ completed in self.delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [], transitionCompleted: completed) })
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed {
                if let currentViewController = pageViewController.viewControllers?.first,
                   let index = pages.firstIndex(of: currentViewController) {
                    self.current?(index)
//                    if let parent = parent as? HomeViewController {
//                        parent.layout.view_banners.set(index: index, total: pages.count)
//                    }
                }
            }
        }
    }

    class PageViewController<T, U: BaseLayout>: UIViewController {
        
        var index = 0
        var item: T? = nil
        var layout = U()
        var inflate: ((Int, T, U) -> Void)? = nil
        
        convenience init(index: Int, item: T, inflate: @escaping (Int, T, U) -> Void) {
            self.init()
            self.index = index
            self.item = item
            self.inflate = inflate
        }
        
        override func viewDidLoad() {
            layout.initViews(view)
            if let item = item {
                inflate?(index, item, layout)
            }
        }
    }
}
