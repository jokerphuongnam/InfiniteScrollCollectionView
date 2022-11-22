//
//  InfiniteScrollCollectionDataSource.swift
//  InfiniteScrollCollectionView
//
//  Created by P.Nam on 18/11/2022.
//

import UIKit

internal final class InfiniteScrollCollectionDataSource: NSObject {
    weak var dataSource: InfiniteScrollCollectionViewDataSource!
    
    init(_ dataSource: InfiniteScrollCollectionViewDataSource?) {
        self.dataSource = dataSource
    }
}

extension InfiniteScrollCollectionDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        let count = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
        if count > 0 {
            let numberOfSets = dataSource.numberOfSets(in: collectionView)
            return count + (2 * numberOfSets)
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataSource = dataSource else { return UICollectionViewCell(frame: .zero) }
        let realCount = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
        if realCount > 0 {
            let numberOfSets = dataSource.numberOfSets(in: collectionView)
            var calculateIndex = (indexPath.row - numberOfSets) % realCount
            if calculateIndex < 0  {
                calculateIndex = realCount - abs(calculateIndex)
            }
            return dataSource.collectionView(collectionView, cellForItemAt: IndexPath(item: calculateIndex, section: 0))
        } else {
            return dataSource.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
}
