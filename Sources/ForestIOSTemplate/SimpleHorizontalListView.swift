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
    
    var cellInitSize: CGSize = .zero
    var sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var minimumLineSpacing: CGFloat = 0
    var minimumInteritemSpacing: CGFloat = 0
    
    public var count: (() -> Int)? = nil
    public var cellSize: ((IndexPath) -> CGSize)? = nil
    public var cellData: ((UICollectionView?, IndexPath) -> UICollectionViewCell)? = nil
    public var onTouch: ((IndexPath) -> Void)? = nil
    
    public convenience init(cellSize: CGSize, sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), minimumLineSpacing: CGFloat = 0, minimumInteritemSpacing: CGFloat = 0) {
        self.init()
        self.cellInitSize = cellSize
        self.sectionInset = sectionInset
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
    }
    
    open override func initViews(parent: UIViewController?) {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = sectionInset
        layout.itemSize = cellInitSize
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumInteritemSpacing // vertical
        
        tableView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        if let table_main = tableView {
            addSubview(table_main)
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

