//
//  LoadMoreView.swift
//  altar
//
//  Created by Tri on 2020/09/17.
//

import UIKit

class LoadMoreView: BaseView {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func showLoading() {
        indicatorView.isHidden = false
        indicatorView.startAnimating()
    }
    
    func hideLoading() {
        indicatorView.isHidden = true
        indicatorView.stopAnimating()
    }

}
