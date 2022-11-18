//
//  NSObject+Extension.swift
//  InfiniteScrollCollectionView
//
//  Created by P.Nam on 18/11/2022.
//

import Foundation

internal extension NSObject {
    class var name: String {
        String(describing: Self.self)
    }
}

internal extension NSObject {
    func getAssociatedObject<T>(_ key: UnsafeRawPointer) -> T? {
        return objc_getAssociatedObject(self, key) as? T
    }

    func setRetainedAssociatedObject<T>(_ key: UnsafeRawPointer, _ value: T) {
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func removeRetainedAssociatedObject(_ key: UnsafeRawPointer) {
        objc_setAssociatedObject(self, key, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
