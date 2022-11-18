//
//  InfiniteScrollCollectionViewDataSource.swift
//  InfiniteScrollCollectionView
//
//  Created by P.Nam on 11/11/2022.
//

import UIKit

public protocol InfiniteScrollCollectionViewDataSource: AnyObject {
    func numberOfSets(in collectionView: UICollectionView) -> Int
    func collectionView(count collectionView: UICollectionView) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}
