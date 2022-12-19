//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/19.
//

import Foundation
import UIKit
import SnapKit

class SimpleVerticalListView: BaseView, UITableViewDataSource, UITableViewDelegate {
    
    let table_main = UITableView(frame: .zero, style: .grouped)
    var count: (() -> Int)? = nil
    var cellHeight: ((IndexPath) -> CGFloat)? = nil
    var cellData: ((UITableView, IndexPath) -> UITableViewCell)? = nil
    var onTouch: ((IndexPath) -> Void)? = nil
    
    override func initViews(parent: UIViewController?) {
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count?() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight?(indexPath) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellData?(tableView, indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTouch?(indexPath)
    }
}
