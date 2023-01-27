//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/27.
//

import Foundation
import UIKit
import SnapKit

open class SimpleSectionVerticalListView: BaseView, UITableViewDataSource, UITableViewDelegate {
    
    public let table_main = UITableView(frame: .zero, style: .grouped)
    
    public var sectionCount: (() -> Int)? = nil
    public var sectionHeight: ((Int) -> CGFloat)? = nil
    public var sectionData: ((UITableView, Int) -> UITableViewHeaderFooterView?)? = nil
    
    public var count: ((Int) -> Int)? = nil
    public var cellHeight: ((IndexPath) -> CGFloat)? = nil
    public var cellData: ((UITableView, IndexPath) -> UITableViewCell)? = nil
    public var onTouch: ((IndexPath) -> Void)? = nil
    
    open override func initViews(rootView: UIView) {
        rootView.addSubview(table_main)
        table_main.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        table_main.delegate = self
        table_main.dataSource = self
        table_main.separatorStyle = .none
    }
    
    open func setSection(count: @escaping () -> Int, height: @escaping (Int) -> CGFloat, data: @escaping (UITableView, Int) -> UITableViewHeaderFooterView?) {
        self.sectionCount = count
        self.sectionHeight = height
        self.sectionData = data
    }
    
    open func set(register: @escaping (UITableView) -> Void, count: @escaping (Int) -> Int, cellHeight: @escaping (IndexPath) -> CGFloat, cellData: @escaping (UITableView, IndexPath) -> UITableViewCell, onTouch: @escaping (IndexPath) -> Void) {
        register(table_main)
        self.cellHeight = cellHeight
        self.cellData = cellData
        self.count = count
        self.onTouch = onTouch
    }
    
    open func calculateHeight() -> CGFloat {
        var totalHeights: CGFloat = 0
        for i in 0..<(sectionCount?() ?? 0) {
            for j in 0..<(count?(i) ?? 0) {
                totalHeights += (cellHeight?(IndexPath(row: j, section: i)) ?? 0)
            }
        }
        return totalHeights
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionData?(tableView, section) ?? nil
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount?() ?? 1
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeight?(section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count?(section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight?(indexPath) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellData?(tableView, indexPath) ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTouch?(indexPath)
    }
}
