//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/23.
//

import Foundation
import UIKit
import SnapKit

open class SimpleHorizontalListView: BaseView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public var tableView: UICollectionView?
    
    public var count: (() -> Int)? = nil
    public var cellSize: ((IndexPath) -> CGSize)? = nil
    public var cellData: ((UICollectionView?, IndexPath) -> UICollectionViewCell)? = nil
    public var onTouch: ((IndexPath) -> Void)? = nil
    
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
    
    open override func initViews(rootView: BaseView) {
        initTable(layout: nil)
    }
    
    func initTable(layout: UICollectionViewFlowLayout?) {
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
    
    public func set(register: @escaping (UICollectionView?) -> Void, count: @escaping () -> Int, cellSize: @escaping (IndexPath) -> CGSize, cellData: @escaping (UICollectionView?, IndexPath) -> UICollectionViewCell, onTouch: @escaping (IndexPath) -> Void) {
        register(tableView)
        self.cellSize = cellSize
        self.cellData = cellData
        self.count = count
        self.onTouch = onTouch
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize?(indexPath) ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count?() ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellData?(tableView, indexPath) ?? UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTouch?(indexPath)
    }
}

