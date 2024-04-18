//
//  CollectionView+Ext.swift
//  PhotoEditorApp
//
//  Created by Avi Kheni on 18/04/24.
//

import Foundation
import UIKit
extension UICollectionView {

    func registerUINib(identifier: IdentifierName) {
        self.register(UINib(nibName: identifier.rawValue, bundle: nil), forCellWithReuseIdentifier: identifier.rawValue)
    }
}

