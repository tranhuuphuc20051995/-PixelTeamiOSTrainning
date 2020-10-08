//
//  BaseUITableVIewCell.swift
//  altar
//
//  Created by Tri on 2020/09/04.
//

import Foundation

open class BaseUITableVIewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    lazy var tapGesture = UITapGestureRecognizer()

    open override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
