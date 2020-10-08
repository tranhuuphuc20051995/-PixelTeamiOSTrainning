//
//  BaseView.swift
//  altar
//
//  Created by Tri on 2020/08/11.
//

import UIKit

class BaseView: UIView {
    
    var nibView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let view = UIView.loadXibView(fromNib: type(of: self),owner: self)
        self.addSubview(view)
        self.nibView = view
        self.nibView.bindFrame(to: self)
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = UIView.loadXibView(fromNib: type(of: self),owner: self)
        self.addSubview(view)
        self.nibView = view
        self.nibView.bindFrame(to: self)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nibView.frame = bounds
    }
    
    func setupView() {
    }
}
