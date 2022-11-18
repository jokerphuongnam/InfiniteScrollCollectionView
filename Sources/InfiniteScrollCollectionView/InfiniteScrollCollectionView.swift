//
//  InfiniteScrollCollectionView.swift
//  InfiniteScrollCollectionView
//
//  Created by P.Nam on 11/11/2022.
//

import UIKit

private var dataSourceKey: Void?

open class InfiniteScrollCollectionView: UICollectionView {
    private var isLayoutSubViews = false
    private var isConfig = false
    var numberOfSets: Int = 0
    private var count: Int {
        infiniteDataSource?.collectionView(count: self) ?? 0
    }
    
    open weak var infiniteDataSource: InfiniteScrollCollectionViewDataSource! {
        willSet {
            if let newValue = newValue {
                setRetainedAssociatedObject(&dataSourceKey, InfiniteScrollCollectionDataSource(newValue))
                dataSource = getAssociatedObject(&dataSourceKey)
                numberOfSets = newValue.numberOfSets(in: self)
                if isLayoutSubViews {
                    layoutIfNeeded()
                    resetPosition()
                }
            } else {
                removeRetainedAssociatedObject(&dataSourceKey)
            }
        }
    }
    
    open override var contentOffset: CGPoint {
        didSet {
            guard infiniteDataSource != nil else {
                return
            }
            if !visibleCells.isEmpty {
                var indexPaths = [IndexPath]()
                for cell in visibleCells {
                    guard let indexPath = indexPath(for: cell) else { continue }
                    indexPaths.append(indexPath)
                }
                infiniteScroll(visibleIndexPaths: indexPaths)
            }
        }
    }
    
    open override func layoutSubviews() {
        isLayoutSubViews = true
        super.layoutSubviews()
        if !isConfig {
            isConfig = true
            resetPosition()
        }
    }
    
    open func infiniteScroll(visibleIndexPaths indexPaths: [IndexPath]) {
        let indexPathSort = indexPaths.sorted { lhs, rhs in
            lhs.item < rhs.item
        }
        guard let lastIndexPath = indexPathSort.last else {
            return
        }
        if lastIndexPath.item == numberOfSets - 1 {
            scrollToItem(at: [0, count + numberOfSets - 1], at: .right, animated: false)
            scrollToItem(at: [0, count + numberOfSets - 1], at: .bottom, animated: false)
        } else if lastIndexPath.item == count + numberOfSets + 1 {
            scrollToItem(at: [0, numberOfSets], at: .right, animated: false)
            scrollToItem(at: [0, numberOfSets], at: .bottom, animated: false)
        }
    }
    
    private func resetPosition() {
        layoutIfNeeded()
        let item = infiniteDataSource.numberOfSets(in: self)
        let section = 0
        let indexPath = IndexPath(item: item, section: section)
        scrollToItem(at: indexPath, at: .top, animated: false)
        scrollToItem(at: indexPath, at: .left, animated: false)
    }
}
