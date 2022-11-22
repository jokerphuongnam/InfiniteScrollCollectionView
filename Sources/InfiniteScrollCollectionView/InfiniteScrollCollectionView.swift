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
        infiniteDataSource?.collectionView(self, numberOfItemsInSection: 0) ?? 0
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
            let infiniteIndexPathsForVisibleItems = infiniteIndexPathsForVisibleItems
            if !infiniteIndexPathsForVisibleItems.isEmpty {
                infiniteScroll(visibleIndexPaths: infiniteIndexPathsForVisibleItems)
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
        guard let lastIndexPath = indexPathSort.last, let firstIndexPath = indexPathSort.first else {
            return
        }
        var toItem: Int? = nil
        let count = count
        let leftIndexPath = firstIndexPath.item != 0 ? firstIndexPath.item : lastIndexPath.item
        let rightIndexPath = lastIndexPath.item != 0 ? lastIndexPath.item : firstIndexPath.item
        if leftIndexPath == numberOfSets {
            toItem = count + numberOfSets
        } else if rightIndexPath == count + numberOfSets + 1 {
            toItem = numberOfSets + 1
        }
        if let toItem = toItem, count > 0 {
            infiniteScrollToItem(at: [0, toItem], at: .right)
            infiniteScrollToItem(at: [0, toItem], at: .bottom)
        }
    }
    
    private func resetPosition() {
        guard count > 0 else { return }
        let item = numberOfSets + 1
        let section = 0
        let indexPath = IndexPath(item: item, section: section)
        infiniteScrollToItem(at: indexPath, at: .top)
        infiniteScrollToItem(at: indexPath, at: .left)
        layoutIfNeeded()
    }
}
