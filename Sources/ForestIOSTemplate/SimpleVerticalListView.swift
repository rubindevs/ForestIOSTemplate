//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/19.
//

import Foundation
import UIKit
import SnapKit

open class SimpleVerticalListView: BaseView, UITableViewDataSource, UITableViewDelegate {
    
    public let table_main = UITableView(frame: .zero, style: .grouped)
    public var count: (() -> Int)? = nil
    public var cellHeight: ((IndexPath) -> CGFloat)? = nil
    public var cellData: ((UITableView, IndexPath) -> UITableViewCell)? = nil
    public var onTouch: ((IndexPath) -> Void)? = nil
    
    open override func initViews(parent: UIViewController?) {
        addSubview(table_main)
        table_main.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        table_main.delegate = self
        table_main.dataSource = self
        table_main.separatorStyle = .none
    }
    
    func set(register: @escaping (UITableView) -> Void, count: @escaping () -> Int, cellHeight: @escaping (IndexPath) -> CGFloat, cellData: @escaping (UITableView, IndexPath) -> UITableViewCell, onTouch: @escaping (IndexPath) -> Void) {
        register(table_main)
        self.cellHeight = cellHeight
        self.cellData = cellData
        self.count = count
        self.onTouch = onTouch
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count?() ?? 0
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
