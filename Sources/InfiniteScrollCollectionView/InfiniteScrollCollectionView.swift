//
//  InfiniteScrollCollectionView.swift
//  InfiniteScrollCollectionView
//
//  Created by P.Nam on 11/11/2022.
//

import UIKit

private var dataSourceKey: Void?

open class InfiniteScrollCollectionView: UICollectionView, BaseInfiniteScrollCollectionView {
    open var infiniteIndexPathsForVisibleItems: [IndexPath] {
        indexPathsForVisibleItems
    }
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
                if !isLayoutSubViews {
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
        let leftIndexPath = firstIndexPath.item != 0 ? firstIndexPath.item : lastIndexPath.item
        let rightIndexPath = lastIndexPath.item != 0 ? lastIndexPath.item : firstIndexPath.item
        if leftIndexPath == numberOfSets {
            toItem = count + numberOfSets
        } else if rightIndexPath == count + numberOfSets + 1 {
            toItem = numberOfSets + 1
        }
        if let toItem = toItem {
            scrollToItem(at: [0, toItem], at: .right, animated: false)
            scrollToItem(at: [0, toItem], at: .bottom, animated: false)
        }
    }
    
    open func infiniteScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition) {
        scrollToItem(at: indexPath, at: scrollPosition, animated: false)
        scrollToItem(at: indexPath, at: scrollPosition, animated: false)
    }
    
    private func resetPosition() {
        guard let infiniteDataSource = infiniteDataSource else { return }
        let item = infiniteDataSource.numberOfSets(in: self) + 1
        let section = 0
        let indexPath = IndexPath(item: item, section: section)
        infiniteScrollToItem(at: indexPath, at: .top)
        infiniteScrollToItem(at: indexPath, at: .left)
        layoutIfNeeded()
    }
}
