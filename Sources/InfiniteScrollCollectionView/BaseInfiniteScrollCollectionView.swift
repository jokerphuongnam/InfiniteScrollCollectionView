//
//  BaseInfiniteScrollCollectionView.swift
//  InfiniteScrollCollectionView
//
//  Created by P.Nam on 22/11/2022.
//

import Foundation
import UIKit

public protocol BaseInfiniteScrollCollectionView {
    var infiniteIndexPathsForVisibleItems: [IndexPath] { get }
    func infiniteScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition)
}

extension UICollectionView: BaseInfiniteScrollCollectionView {
    @objc open var infiniteIndexPathsForVisibleItems: [IndexPath] {
        indexPathsForVisibleItems
    }
    
    @objc open func infiniteScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition) {
        scrollToItem(at: indexPath, at: scrollPosition, animated: false)
        scrollToItem(at: indexPath, at: scrollPosition, animated: false)
    }
}
