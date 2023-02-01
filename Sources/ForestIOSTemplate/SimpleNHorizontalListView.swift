//
//  File.swift
//  
//
//  Created by 염태규 on 2023/02/02.
//

import Foundation
import UIKit

open class SimpleNHorizontalListView<T: NCodable, U: BaseNCollectionViewCell<T>>: BaseNView<T>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public var tableView: UICollectionView?
    public var onTouch: ((T) -> Void)? = nil
    
    public var datas: [T] = []
    public var filter: (T) -> Bool = { data in return true }
    public var onCell: ((T, U) -> Void)? = nil
    
    public convenience init(cellSize: CGSize, scrollDirection: UICollectionView.ScrollDirection, sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), minimumLineSpacing: CGFloat = 0, minimumInteritemSpacing: CGFloat = 0) {
        self.init()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = sectionInset
        layout.itemSize = cellSize
        layout.scrollDirection = scrollDirection
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumInteritemSpacing // vertical
        initTable(layout: layout)
    }
    
    public convenience init(layout: UICollectionViewLayout) {
        self.init()
        initTable(layout: layout)
    }
    
    public var refreshControl: UIRefreshControl? = nil
    public var onRefresh: (() -> Void)? = nil
    open func setOnRefresh(onRefresh: @escaping () -> Void) {
        self.onRefresh = onRefresh
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView?.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        self.refreshControl?.endRefreshing()
        self.onRefresh?()
    }
    
    open override func inflate(datas: [T]) {
        self.datas = datas
        self.tableView?.reloadData()
    }
    
    open override func initViews(rootView: UIView) {
        initTable(layout: nil)
    }
    
    func initTable(layout: UICollectionViewLayout?) {
        tableView?.removeFromSuperview()
        if let layout = layout {
            tableView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        } else {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            tableView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        }
        if let table_main = tableView {
            mainView.addSubview(table_main)
            table_main.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            table_main.backgroundColor = .clear
            table_main.contentInset = .zero
            table_main.delegate = self
            table_main.dataSource = self
            table_main.showsHorizontalScrollIndicator = false
        }
    }
    
    open func set(onTouch: @escaping (T) -> Void) {
        tableView?.register(U.self, forCellWithReuseIdentifier: String(describing: U.self))
        self.onTouch = onTouch
    }
    
    open func setOnCell(onCell: @escaping (T, U) -> Void) {
        self.onCell = onCell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return datas.filter(self.filter)[indexPath.row].size
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.emptyView.isHidden = !(datas.filter(self.filter).count == 0 && isEmpty)
        return datas.filter(self.filter).count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let onTouch = onTouch {
            let cell = tableView?.dequeueReusableCell(withReuseIdentifier: String(describing: U.self), for: indexPath) as! U
            cell.set(data: datas.filter(self.filter)[indexPath.row])
            onCell?(datas.filter(self.filter)[indexPath.row], cell)
            return cell
        }
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
