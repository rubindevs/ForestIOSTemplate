//
//  File.swift
//  
//
//  Created by 염태규 on 2023/01/27.
//

import Foundation
import UIKit

public class SimpleNVerticalListView<T: NCodable, U: BaseNTableViewCell<T>>: BaseNView<T>, UITableViewDataSource, UITableViewDelegate {
    
    public let table_main = UITableView(frame: .zero, style: .grouped)
    public var onTouch: ((T) -> Void)? = nil
    
    public var datas: [T] = []
    public var onCell: ((T, U) -> Void)? = nil
    
    open override func initViews(rootView: BaseView) {
        rootView.addSubview(table_main)
        table_main.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        table_main.delegate = self
        table_main.dataSource = self
        table_main.separatorStyle = .none
    }
    
    open override func inflate(datas: [T]) {
        self.datas = datas
        self.table_main.reloadData()
    }
    
    var sectionView: SimpleTitleSectionView? = nil
    var headerHeight: CGFloat = 0
    open func set(title: ViewText, intervalH: CGFloat, intervalV: CGFloat, headerHeight: CGFloat = 0) {
        self.headerHeight = headerHeight
        let sectionView = SimpleTitleSectionView()
        sectionView.set(title: title, intervalH: intervalH, intervalV: intervalV)
        self.sectionView = sectionView
    }
    
    open func set(onTouch: @escaping (T) -> Void) {
        table_main.register(U.self, forCellReuseIdentifier: String(describing: U.self))
        self.onTouch = onTouch
    }
    
    open func onCell(onCell: @escaping (T, U) -> Void) {
        self.onCell = onCell
    }
    
    open func calculateHeight() -> CGFloat {
        var totalHeights: CGFloat = 0
        for data in datas {
            totalHeights += data.height()
        }
        return totalHeights
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionView
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return datas[indexPath.row].height()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let onTouch = onTouch {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: U.self), for: indexPath) as! U
            cell.set(data: datas[indexPath.row])
            onCell?(datas[indexPath.row], cell)
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTouch?(datas[indexPath.row])
    }
}
