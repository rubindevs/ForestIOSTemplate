//
//  File.swift
//  
//
//  Created by 염태규 on 2023/01/27.
//

import Foundation
import UIKit

public class SimpleNSectionVerticalListView<T: NCodable, U: BaseTableViewHeaderFooterView, V: BaseNTableViewCell<T>>: BaseNView<T>, UITableViewDataSource, UITableViewDelegate {
    
    public let table_main = UITableView(frame: .zero, style: .grouped)
    public var onTouch: ((T) -> Void)? = nil
    
    public var datas: [T] = []
    public var onSection: ((U?) -> Void)? = nil
    public var onCell: ((T, V) -> Void)? = nil
    public var sectionHeight: CGFloat = 0
    
    open override func initViews(rootView: UIView) {
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
    
    open func set(sectionHeight: CGFloat, onTouch: @escaping (T) -> Void) {
        self.sectionHeight = sectionHeight
        table_main.register(U.self, forHeaderFooterViewReuseIdentifier: String(describing: U.self))
        table_main.register(V.self, forCellReuseIdentifier: String(describing: V.self))
        self.onTouch = onTouch
    }
    
    open func onSection(onSection: @escaping (U?) -> Void) {
        self.onSection = onSection
    }
    
    open func onCell(onCell: @escaping (T, V) -> Void) {
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
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: U.self)) as? U
        self.onSection?(view)
        return view
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeight
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return datas[indexPath.row].height()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let onTouch = onTouch {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: V.self), for: indexPath) as! V
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
