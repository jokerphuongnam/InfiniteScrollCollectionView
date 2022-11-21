//
//  InfiniteScrollCollectionViewDataSource.swift
//  InfiniteScrollCollectionView
//
//  Created by P.Nam on 11/11/2022.
//

import UIKit

public protocol InfiniteScrollCollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSets(in collectionView: UICollectionView) -> Int
}
