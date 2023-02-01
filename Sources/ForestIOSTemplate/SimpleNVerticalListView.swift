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
    public var filter: (T) -> Bool = { data in return true }
    public var onCell: ((T, U) -> Void)? = nil
    
    open override func initViews(rootView: UIView) {
        rootView.addSubview(table_main)
        table_main.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        table_main.delegate = self
        table_main.dataSource = self
        table_main.separatorStyle = .none
    }
    
    public var refreshControl: UIRefreshControl? = nil
    public var onRefresh: (() -> Void)? = nil
    open func setOnRefresh(onRefresh: @escaping () -> Void) {
        self.onRefresh = onRefresh
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        table_main.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        self.refreshControl?.endRefreshing()
        self.onRefresh?()
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
    
    open func setOnCell(onCell: @escaping (T, U) -> Void) {
        self.onCell = onCell
    }
    
    open func setFilter(filter: @escaping (T) -> Bool) {
        self.filter = filter
        self.table_main.reloadData()
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
        self.emptyView.isHidden = !(datas.filter(self.filter).count == 0 && isEmpty)
        return datas.filter(self.filter).count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return datas.filter(self.filter)[indexPath.row].height()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let onTouch = onTouch {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: U.self), for: indexPath) as! U
            cell.set(data: datas.filter(self.filter)[indexPath.row])
            onCell?(datas.filter(self.filter)[indexPath.row], cell)
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTouch?(datas.filter(self.filter)[indexPath.row])
    }
    
    var isEmpty = false
    public func setEmptyView(view: BaseView) {
        self.emptyView.subviews.forEach { $0.removeFromSuperview() }
        self.emptyView.addSubview(view)
        view.makeEasyConstraintsFull()
        isEmpty = true
    }
}
