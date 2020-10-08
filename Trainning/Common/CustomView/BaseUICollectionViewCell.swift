//
//  BaseUICollectionViewCell.swift
//  altar
//
//  Created by Tri on 2020/09/27.
//

import Foundation

open class BaseUICollectionViewCell: UICollectionViewCell {
    
    var disposeBag = DisposeBag()
    
    lazy var tapGesture = UITapGestureRecognizer()

    open override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

