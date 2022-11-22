//
//  BaseInfiniteScrollCollectionView.swift
//  InfiniteScrollCollectionView
//
//  Created by P.Nam on 22/11/2022.
//

import Foundation
import UIKit

protocol BaseInfiniteScrollCollectionView {
    var infiniteIndexPathsForVisibleItems: [IndexPath] { get }
    func infiniteScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition)
}
