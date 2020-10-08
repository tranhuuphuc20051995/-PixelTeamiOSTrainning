//
//  CollectionView+.swift
//  altar
//
//  Created by Tri on 2020/08/07.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    /// This is a workaround method for self sizing collection view cells which stopped working for iOS 12
    func setupSelfSizingForiOS12(contentView: UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}

extension UICollectionView {
    
    func registerCell<T>(ofType type: T.Type) {
        let typeName = String(describing: type)
        self.register(UINib(nibName: typeName, bundle: nil), forCellWithReuseIdentifier: typeName)
    }
    
    func dequeueCell<T>(indexPath : IndexPath) -> T {
        let typeName = String(describing: T.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: typeName, for: indexPath) as? T else {
            fatalError("couldnt dequeue cell with identifier \(typeName)")
        }
        return cell
    }
}


